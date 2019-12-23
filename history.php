
<!doctype html>
<html dir="ltr" lang="en">
<head>
  <meta charset="utf8">
  <title>TicketHistory</title>

  <link rel="stylesheet" href="chrome://resources/css/md_colors.css">

  <style>
    html {
      /* Remove 300ms delay for 'click' event, when using touch interface. */
      touch-action: manipulation;
    }

    html,
    body {
      height: 100%;
      margin: 0;
      overflow: hidden;
    }

    body {
      background: var(--md-background-color);
      cursor: default;
    }

    
    .loading history-app {
      visibility: hidden;
    }

    #app-shim {
      display: none;
    }

    .loading #app-shim {
      bottom: 0;
      display: flex;
      flex-direction: column;
      font-size: 123%;
      height: 100%;
      left: 0;
      position: absolute;
      right: 0;
      top: 0;
    }

    #app-shim span {
      display: flex;
    }

    #loading-toolbar {
      align-items: center;
      background: var(--md-toolbar-color);
      border-bottom: var(--md-toolbar-border);
      box-sizing: border-box;
      color: #fff;
      height: var(--md-toolbar-height);
      letter-spacing: .25px;
      padding-inline-start: 24px;
    }

    @media (prefers-color-scheme: dark) {
      #loading-toolbar {
        color: rgb(232, 234, 237);  /* --google-grey-200 */
      }
    }

    #loading-message {
      align-items: center;
      color: var(--md-loading-message-color);
      flex: 1;
      font-weight: 500;
      justify-content: center;
    }
  </style>
</head>

<body class="loading">
  <history-app id="history-app"></history-app>

  <div id="app-shim">
    <span id="loading-toolbar">History</span>
    
  </div>

  <command id="delete-command" shortcut="Delete Backspace">


  <command id="select-all-command" shortcut="Ctrl|a">


  
  <script src="history.js"></script>

  <link rel="import" href="app.html" async id="bundle">
</body>

</html>
