<%@include file="connect.jsp"%>
<%
String scheduleid=request.getParameter("Date");
String time=request.getParameter("Time");
String crno=request.getParameter("crno");
String uid=(String)session.getAttribute("uid");
String crid=(String)session.getAttribute("crid");
String seats=request.getParameter("seats");
String film=request.getParameter("Film");
String cinema=request.getParameter("Cinema");
String address="",screenid="",showdate="",solddate=(new java.util.Date()).toLocaleString();
long balance=0,cost=0,ticket=0;
String name="",seatstr="";
String sql;

if(uid==null){%>
		<div style='color:red'><h2>You must be logged in to buy tickets</h2></div>
<%}else{
	rs=st.executeQuery("select crno,balance from Credit where id="+crid);
	if(rs.next()){
		if(rs.getString(1).equals(crno)){
			balance=rs.getLong(2);
			rs=st.executeQuery("select fname,mname,lname from Customer where id="+uid);
			if(rs.next())	name=rs.getString(1)+" "+rs.getString(2)+" "+rs.getString(3);
			String[] seatlist=seats.split(";");
			String alpha="ABCDE";
			int seat[]=new int[seatlist.length];
			for(int i=0;i<seatlist.length;i++) seat[i]=Integer.parseInt(seatlist[i]);
			for(int i=0;i<seat.length;i++){
				if(seat[i] < 41) cost+=75;
				else if(seat[i] < 81) cost+=100;
				else cost+=125;
			}			
			if(balance>cost){
				balance-=cost;
				for(int i=0;i<seatlist.length;i++) seatstr+= Character.toString(alpha.charAt(seat[i]/20))+ seat[i]%20 + ",";
				rs=st.executeQuery("select Name from Film where id="+ film);
				if(rs.next()) film=rs.getString(1);
				rs=st.executeQuery("select Address from Cinema where id="+ cinema);
				if(rs.next()){ address=rs.getString(1); }
				rs=st.executeQuery("select Format(Showdate,'dd mmmm,yyyy'), screenid from Schedule where id="+scheduleid );
				if(rs.next()){showdate=rs.getString(1);screenid=rs.getString(2);}
				rs=st.executeQuery("Select Format(Slot,'hh:nn AM/PM') from ttime,screen where ttime.id=screen.timeid and screen.id="+screenid +" and slotno='"+time+"'");								
				if(rs.next()){showdate+=" "+ rs.getString(1);}
				rs=st.executeQuery("select max(id) from Ticket");
				if(rs.next()) ticket=rs.getInt(1)+1;
				String insert="INSERT INTO Ticket( ID, customerid, ScheduleID, Seats, Quantity, amount, SoldDate, Timeslot) values("+ticket+","+uid+",";
				insert+=scheduleid+",'"+seats+"',"+seatlist.length+","+cost+",'"+solddate+"','"+time+"')";
				System.out.println (insert);
				st.executeUpdate(insert);
				st.executeUpdate("update credit set balance="+balance+" where id="+crid);
				st.executeUpdate("update Customer set totaltkt=totaltkt+"+seat.length+" where id="+uid);%>
				<table><tr><td>
				<div id="ticket"><table border="1">
				<tr align="center"><td><h1>Dream World Cinemas</h1></td></tr>
				<tr><td><table>
					<tr><td>Ticket No. <%=ticket%></td><td>Customer No. <%=uid%></td></tr>
					<tr><td>Customer Name</td><td><%=name%></td></tr>
					<tr><td>Booked seats</td><td><%=seatstr%></td></tr>
					<tr><td>Show Time</td><td><%=showdate%></td></tr>
					<tr><td>Movie</td><td><%=film%></td></tr>
					<tr><td>Venue</td><td><%=address%></td></tr>
					<tr><td>Sold On</td><td><%=solddate%></td></tr>
					<tr><td>Total Cost</td><td><%=cost%></td></tr>
					<tr><td>Balance Remaining</td><td><%=balance%> BDT</td></tr>
				</table></td></tr>
				</table></div></td></tr>
				<tr><td align="center"><a href="javascript:printTicket()" class="navigation">Print</a></td></tr>
				</table>
<%			}else{%>
				<div style='color:red'><h2>You don't have sufficient balance to buy tickets.<br>
					Please recharge your Account<br>Your current balance is <%=balance%></h2></div>
<%			}
		}else{%>			
			<form name='regform'><table><tr><td colspan='2' align="center"><h2>Confirm Ticket Book</h2></td></tr>
			<tr><td>Creditcard No</td><td><input type='text' id='crno' value='<%=crno%>' onkeyup='javascript:checkcrno()'/>
				<label id='m_crno' style="color:red;">Your Credit Card No do not match</label></td></tr>
			<tr><td><a href='javascript:confirmBookTicket()' class='navigation'>Confirm</a></td>
			<td><a href='#schedule' class='navigation'>Cancel</a></td></tr></table></form>
<%		}
	}
}
conn.close();
%>