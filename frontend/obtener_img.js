var apiIP = "34.72.250.6"; 

function obtenerImagenes() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', `http://${apiIP}:3000/likes`, true);
    xhr.onload = function () {
        if (xhr.status === 200) {
            var images = JSON.parse(xhr.response); // Convertir la respuesta a un objeto JavaScript
            console.log(images);

            images.forEach(imageUrl => {
                var img = document.createElement('img');
                img.src = imageUrl;
                img.width = 400;
                img.height = 400;
                imageContainer.appendChild(img);
            });
        }
    };
    xhr.send();
}
obtenerImagenes();

