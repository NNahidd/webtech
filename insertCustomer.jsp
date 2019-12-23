<%@include file="connect.jsp"%>
<%
String uid= (String)session.getAttribute("uid");
String uname=request.getParameter("uname");
String email=request.getParameter("email");
String phno=request.getParameter("phno");
String address=request.getParameter("address");
String city=request.getParameter("City");
String crno=request.getParameter("crno");
String balance=request.getParameter("balance");
if(balance==null||balance.equals("")) balance="0";
boolean creditOk=true;
if(uid!=null&&uid.equals("1")){
	try{
		st.executeUpdate("insert into credit(crno,balance) values('"+crno+"',"+balance+")");
	}catch(Exception e){
		out.println("Credit card No. already in use.\nInsertion could not be processed");
		creditOk=false;
	}
	if(creditOk){
		rs=st.executeQuery("select id from credit where crno='"+ crno +"'");
		rs.next();
		int crid=rs.getInt(1);
		String sql="insert into Customer(uname,passw,email,phno,address,cityid,crid) values(";
		sql+="'"+uname+"','','"+email+"','"+phno+"','"+address+"',"+city+","+crid+")";
		System.out.println(sql);
		try{
			st.executeUpdate(sql);
			out.println("Record has been inserted successfully");
		}
		catch(Exception e){
			out.println("Record could not be inserted.\nMay be you have used an ' (Apostrophe) in data");
			System.out.println(e);
		}
	}
}else{
	out.println("You should be logged in as Administrator to call this function.\nYour request cannot be permitted");
}
conn.close();%>
