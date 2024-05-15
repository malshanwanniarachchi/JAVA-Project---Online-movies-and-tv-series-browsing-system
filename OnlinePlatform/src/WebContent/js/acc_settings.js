document.addEventListener("DOMContentLoaded", function() {
        // Call your functions here
        showAccountSettings(); // To set the initial state as per your requirements
    });

function showAccountSettings() {
	// Hide all sections
	var sections = document.querySelectorAll(".section");
	for (var i = 0; i < sections.length; i++) {
		sections[i].style.display = "none";
	}
	// Show the Appearance section
	document.getElementById("accountSettings").style.display = "block";
}


function displayPassword() {
	var sections = document.querySelectorAll(".section");
	for (var i = 0; i < sections.length; i++) {
		sections[i].style.display = "none";
	}
	// Show the Password section
	document.getElementById("passwordSettings").style.display = "block";
}


function changePassword() {
	var prevPassword = document.getElementById("prevPassword").value;
	var newPassword = document.getElementById("newPassword").value;
	var confirmPassword = document.getElementById("confirmPassword").value;

	// Validate the input and perform password change if valid
	if (prevPassword === "" || newPassword === "" || confirmPassword === "") {
		alert("Please fill in all fields.");
		return false;
	} else if (newPassword !== confirmPassword) {
		alert("New password and confirm password do not match.");
		return false;
	}
	return true;
}


