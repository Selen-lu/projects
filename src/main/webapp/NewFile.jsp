<!doctype html>
<html>
<head>
  <title>Google I/O YouTube Codelab</title>
  <link type="text/css" rel="stylesheet" href="index.css">
  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  <script type="text/javascript" src="//www.google.com/jsapi"></script>
  <script type="text/javascript" src="isaac.json"></script>
  <script type="text/javascript" src="https://apis.google.com/js/client.js?onload=onJSClientLoad"></script>
</head>
<body>
  <div id="login-container" class="pre-auth">This application requires access to your YouTube account.
    Please <a href="#" id="login-link">authorize</a> to continue.
  </div>
  <div class="post-auth">
    <div id="message"></div>
    <div id="chart"></div>
    <div>Choose a Video:</div>
    <ul id="video-list"></ul>
  </div>
</body>



<script>
(function() {

	  // Retrieve your client ID from the Google API Console at
	  // https://console.developers.google.com/.
	  var OAUTH2_CLIENT_ID = '194183247141-15k6ms8a3cl5b13pm18ddrm53unaq44g.apps.googleusercontent.com';
	  var OAUTH2_SCOPES = [
	    'https://www.googleapis.com/auth/yt-analytics.readonly',
	    'https://www.googleapis.com/auth/youtube.readonly'
	  ];

	  // Upon loading, the Google APIs JS client automatically invokes this callback.
	  // See https://developers.google.com/api-client-library/javascript/features/authentication 
	  window.onJSClientLoad = function() {
	    gapi.auth.init(function() {
	      window.setTimeout(checkAuth, 1);
	    });
	  };

	  // Attempt the immediate OAuth 2.0 client flow as soon as the page loads.
	  // If the currently logged-in Google Account has previously authorized
	  // the client specified as the OAUTH2_CLIENT_ID, then the authorization
	  // succeeds with no user intervention. Otherwise, it fails and the
	  // user interface that prompts for authorization needs to display.
	  function checkAuth() {
	    gapi.auth.authorize({
	      client_id: OAUTH2_CLIENT_ID,
	      scope: OAUTH2_SCOPES,
	      immediate: true
	    }, handleAuthResult);
	  }

	  // Handle the result of a gapi.auth.authorize() call.
	  function handleAuthResult(authResult) {
	    if (authResult) {
	      // Authorization was successful. Hide authorization prompts and show
	      // content that should be visible after authorization succeeds.
	      $('.pre-auth').hide();
	      $('.post-auth').show();

	      loadAPIClientInterfaces();
	    } else {
	      // Authorization was unsuccessful. Show content related to prompting for
	      // authorization and hide content that should be visible if authorization
	      // succeeds.
	      $('.post-auth').hide();
	      $('.pre-auth').show();

	      // Make the #login-link clickable. Attempt a non-immediate OAuth 2.0
	      // client flow. The current function is called when that flow completes.
	      $('#login-link').click(function() {
	        gapi.auth.authorize({
	          client_id: OAUTH2_CLIENT_ID,
	          scope: OAUTH2_SCOPES,
	          immediate: false
	        }, handleAuthResult);
	      });
	    }
	  }

	  // This helper method displays a message on the page.
	  function displayMessage(message) {
	    $('#message').text(message).show();
	  }

	  // This helper method hides a previously displayed message on the page.
	  function hideMessage() {
	    $('#message').hide();
	  }
	  /* In later steps, add additional functions above this line. */
	})();
</script>
</html>