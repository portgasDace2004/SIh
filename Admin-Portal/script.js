document.getElementById("Cards").onmousemove = e => {
    for(const card of document.getElementsByClassName("Card")) {
      const rect = card.getBoundingClientRect(),
            x = e.clientX - rect.left,
            y = e.clientY - rect.top;
  
      card.style.setProperty("--mouse-x", `${x}px`);
      card.style.setProperty("--mouse-y", `${y}px`);
    };
  }

// Initialize Firebase with your Firebase project configuration
var firebaseConfig = {
  apiKey: "AIzaSyDhPxHN5uIQ62ihOBl1fnKavQfJBtBnWfE",
  authDomain: "street-park-5fda5.firebaseapp.com",
  databaseURL: "https://street-park-5fda5-default-rtdb.asia-southeast1.firebasedatabase.app/",
  projectId: "street-park-5fda5 ",
  storageBucket: "street-park-5fda5.appspot.com",
  messagingSenderId: "50126701860",
  appId: "1:50126701860:web:2bb4dd87cf8bcbc5da9fb1"
};

firebase.initializeApp(firebaseConfig);

// Reference to the Firebase database
var database = firebase.database();

// Reference to the HTML element where data will be displayed
var dataList = document.getElementById('rev');

// Function to fetch data from Firebase and display it in HTML
function fetchDataAndDisplay() {
  database.ref('data').once('value').then(function(snapshot) {
    var data = snapshot.val();
    dataList.innerHTML = ''; // Clear previous data

    if (data) {
      Object.keys(data).forEach(function(key) {
        var listItem = document.createElement('li');
        listItem.textContent = data[key];
        dataList.appendChild(listItem);
      });
    } else {
      var noDataItem = document.createElement('li');
      noDataItem.textContent = 'No data available.';
      dataList.appendChild(noDataItem);
    }
  });
}

// Call the function to fetch data and display on page load
fetchDataAndDisplay();