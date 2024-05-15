function validateContactUs() {
    var msg = document.getElementById("msg").value;

    if (msg.length >= 10) {
        return true;
    } else {
        alert("Message must contain atleast 10 characters.");
        return false;
    }
}

