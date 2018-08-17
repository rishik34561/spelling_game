<!DOCTYPE html>
<%@ page import="rishi.WordPicker" %>

    <html>

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>Test</title>
        <meta name="description" content="An interactive getting started guide for Brackets.">
        <link rel="stylesheet" href="bootstrap/dist/css/bootstrap.min.css"/>
        <link href="https://fonts.googleapis.com/css?family=M+PLUS+Rounded+1c" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Crete+Round" rel="stylesheet">
        
        <style>
            body {

                font-family:'M PLUS Rounded 1c', sans-serif;

            }

            .bold {

                font-weight: bold;
                font-family: 'Crete Round', serif;
                font-size: 25pt;

            }

            #next {
                visibility: hidden;
            }
            
            #spellingPrompt {
                 margin-top: 18px;
            }
            
            #result {
                margin-top: -50px;
            }
            
        </style>

        <script>

            function validateForm() {
                document.getElementById("submit").disabled = true;
                var x = document.getElementById("myText").value;
                var origWord = document.getElementById("hiddenText").value;
                console.log(document.getElementById("hiddenText").value);
                if (x != origWord) {
                    console.log("incorrect");
                    document.getElementById("result").innerHTML = "You are incorrect!";
                    subtractPoints();
                    document.getElementById("next").style.visibility = "visible";
                }
                else {
                    console.log("correct");
                    document.getElementById("result").innerHTML = "You are correct!";
                    addPoints();
                    document.getElementById("next").style.visibility = "visible";
                }
            }

            var points = 0;

            function addPoints() {
                points++;

                if (typeof (Storage) !== "undefined") {
                    // Store
                    localStorage.setItem("points", points);
                    // Retrieve
                    document.getElementById("pointCounter").innerHTML = points;
                } else {
                    document.getElementById("pointCounter").innerHTML = "Sorry, your browser does not support Web Storage...";
                }
            }

            function subtractPoints() {
                points--;

                if (typeof (Storage) !== "undefined") {
                    // Store
                    localStorage.setItem("points", points);
                    // Retrieve
                    document.getElementById("pointCounter").innerHTML = points;
                } else {
                    document.getElementById("pointCounter").innerHTML = "Sorry, your browser does not support Web Storage...";
                }
            }

            window.onload = function () {
                points = localStorage.getItem("points");
                document.getElementById("pointCounter").innerHTML = points;
                document.getElementById("next").onclick = function () {
                    location.reload();
                }
            }

        </script>

    </head>

    <body>

        <!--<h1>Spelling Game</h1>-->
        <nav class="navbar navbar-light bg-light ml-0">
            <span class="navbar-brand mb-0 h1 bold">Spelling Game</span>
        </nav>
        <br>

        <%
            String word = new WordPicker().getWord();
        %>

            <input type="hidden" id="hiddenText" value=<%= word %> >
            <p class="ml-2">Listen to pronunciation</p>
            <audio controls class="ml-2">
                <source src="https://ssl.gstatic.com/dictionary/static/sounds/oxford/<%= word %>--_gb_1.mp3" type="audio/mpeg">                
                Your browser does not support the audio element.
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
            <h4 class="ml-2">Points:<p class="badge ml-2 badge-primary"><span id="pointCounter"></span></p></h4>





    </body>



    </html>