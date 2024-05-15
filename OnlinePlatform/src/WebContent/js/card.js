function validateCard() {
    var cvv = document.getElementById("cvv").value;
    var cardno = document.getElementById("cardno").value;

    var cvvPattern = /^[0-9]{3,4}$/;

    if (cvvPattern.test(cvv) && cardno.length == 16) {
        return true;
    } else {
        alert("Invalid CVV or Cardno.");
        return false;
    }
}

function openConfirmationDialog() {
    document.getElementById("confirmationDialog").style.display = "block";
}

function closeConfirmationDialog() {
    document.getElementById("confirmationDialog").style.display = "none";
}

function deleteCard() {
    fetch(window.location.href, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "deleteCard=true"
    })
    .then(response => {
        if (response.ok) {
            return response.text();
        } else {
            throw new Error("Error1 deleting card");
        }
    })
    .then(data => {
        if (data == "success") {
            closeConfirmationDialog();
            window.location.href = "jsp/myaccount.jsp";
        } else {
            alert("Error2 deleting card");
        }
    })
    .catch(error => {
        alert(error.message);
    });
}