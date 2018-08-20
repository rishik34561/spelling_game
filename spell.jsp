<!DOCTYPE html>
<%@ page import="rishi.*" %>

    <html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Test</title>
        <meta name="description" content="An interactive getting started guide for Brackets.">
        <link rel="stylesheet" href="bootstrap/dist/css/bootstrap.min.css" />
        <link href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Crete+Round" rel="stylesheet">
        <link href="styles.css" rel="stylesheet" type="text/css">

    </head>

    <body>

        <nav class="navbar navbar-light bg-light ml-0">
            <span class="navbar-brand mb-0 h1 bold">Spelling Game</span>
        </nav>
        <br>

        <%!
          public void jspInit() {
            SessionUtil.initialize();
            System.out.println("\n \n ****** session initialize called from JSP init");
          }
        %>

            <%
            int row = SessionUtil.getNextNumber(request);
            String word = WordPicker.getWord(row);
        %>

                <input type="hidden" id="hiddenText" value=<%=word %> >
                <p class="ml-2">Listen to pronunciation</p>
                <audio id="audio" controls class="ml-2">
                    <source id="audioSource" src="https://ssl.gstatic.com/dictionary/static/sounds/oxford/<%= word %>--_gb_1.mp3" type="audio/mpeg">                    Your
                    browser does not support the audio element.
                </audio>

                <br>

                <p id="spellingPrompt" class="ml-2">Type spelling here</p>

                <p class="ml-2">
                    <input type="text" name="myText" id="myText" value="text here" />
                    <input type="button" class="btn btn-primary m-2" id="submit" value="Submit" onclick="validateForm()">
                </p>
                <br>
                <span class="ml-2" type="text" id="result"></span>
                <button class="btn btn-success ml-2 mb-2" id="next">Next</button>
                <br>
                <br>
                <h4 class="ml-2">Points:
                    <p class="badge ml-2 badge-primary"><span id="pointCounter"></span></p>
                </h4>


                <script>

                    if (document.getElementById("hiddenText").value === "done") {
                        console.log("all words used");
                        alert("Game over");
                    }


                    function validateForm() {
                        document.getElementById("submit").disabled = true;
                        var origWord = document.getElementById("hiddenText").value;
                        var x = document.getElementById("myText").value;
                        console.log(document.getElementById("hiddenText").value);
                        if (JSON.stringify(x) === JSON.stringify(origWord)) {
                            console.log("correct");
                            document.getElementById("result").innerHTML = "You are correct!";
                            addPoints();
                            document.getElementById("next").style.visibility = "visible";
                        }
                        else {
                            console.log("incorrect, expected " + origWord + ", actual is " + x);
                            document.getElementById("result").innerHTML = "You are incorrect!";
                            subtractPoints();
                            document.getElementById("next").style.visibility = "visible";
                        }
                    }

                    var points = 0;

                    function addPoints() {
                        points += 1;
                        document.getElementById("pointCounter").innerHTML = points;

                    }

                    function subtractPoints() {
                        points -= 1;
                        document.getElementById("pointCounter").innerHTML = points;


                    }

                    window.onload = function () {
                        document.getElementById("pointCounter").innerHTML = points;
                        document.getElementById("next").onclick = function () {
                            makeRequest();
                            document.getElementById("submit").disabled = false;
                            document.getElementById("next").style.visibility = "hidden";
                            document.getElementById("result").innerHTML = "";
                            document.getElementById("myText").value = "";


                        }
                    }

                    function makeRequest() {
                        var xmlHttpRequest = new XMLHttpRequest();
                        xmlHttpRequest.onreadystatechange = getReadyStateHandler(xmlHttpRequest);
                        xmlHttpRequest.open("POST", "store/sample", true);
                        xmlHttpRequest.setRequestHeader("Content-Type",
                            "application/x-www-form-urlencoded");
                        xmlHttpRequest.send(null);
                    }

                    function getReadyStateHandler(xmlHttpRequest) {

                        // an anonymous function returned
                        // it listens to the XMLHttpRequest instance
                        return function () {
                            if (xmlHttpRequest.readyState == 4) {
                                if (xmlHttpRequest.status == 200) {
                                    console.log("responseText: " + xmlHttpRequest.responseText);
                                    if (xmlHttpRequest.responseText.replace(/(\r\n\t|\n|\r\t)/gm, "") === "done") {
                                        console.log("responseText: " + xmlHttpRequest.responseText);
                                        alert("Game over");
                                        document.getElementById("submit").disabled = true;
                                        document.getElementById("next").style.visibility = "hidden";
                                        document.getElementById("result").innerHTML = "";
                                        document.getElementById("myText").value = "";
                                    }
                                    else if (xmlHttpRequest.responseText.replace(/(\r\n\t|\n|\r\t)/gm, "") !== "done") {
                                        document.getElementById("hiddenText").value = xmlHttpRequest.responseText.replace(/(\r\n\t|\n|\r\t)/gm, "");
                                        var audio = document.getElementById('audio');

                                        document.getElementById("audioSource").src = "https://ssl.gstatic.com/dictionary/static/sounds/oxford/" + xmlHttpRequest.responseText + "--_gb_1.mp3";
                                        audio.load(); //call this to just preload the audio without playing

                                    } else {
                                        alert("HTTP error " + xmlHttpRequest.status + ": " + xmlHttpRequest.statusText);
                                    }
                                }
                            };
                        }
                    }


                </script>



    </body>



    </html>