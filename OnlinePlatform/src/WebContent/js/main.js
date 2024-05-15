// Header request
var xhrHeader = new XMLHttpRequest();
xhrHeader.open('GET', 'header.jsp', true);
xhrHeader.onreadystatechange = function () {
    if (xhrHeader.readyState === 4 && xhrHeader.status === 200) {
        document.getElementById('header').innerHTML = xhrHeader.responseText;
    }
};
xhrHeader.send();

// Footer request
var xhrFooter = new XMLHttpRequest();
xhrFooter.open('GET', 'footer.jsp', true);
xhrFooter.onreadystatechange = function () {
    if (xhrFooter.readyState === 4 && xhrFooter.status === 200) {
        document.getElementById('footer').innerHTML = xhrFooter.responseText;
    }
};
xhrFooter.send();