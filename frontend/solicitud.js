const apiKey = "live_hVU8F4bVnxQkW2scERfYXVckgIB34Z6E7Qx7JyZbcxAVt1nqrqkNz2nNXQ05Zq2v"
const apiIP = "www.cat-feed.online"

window.addEventListener("scroll", function() {
  if ((window.innerHeight + window.scrollY)  >= document.body.offsetHeight ) {
    getPhotos();
  }
});

function getPhotos() {
    const xhr = new XMLHttpRequest();
    xhr.open("GET", `https://api.thecatapi.com/v1/images/search?limit=3&api_key=${apiKey}`, true);

  
    xhr.onload = function() {
      if (xhr.status == 200) {
        const respuesta = xhr.responseText;
        console.log(respuesta);
        const fotos = JSON.parse(respuesta);
  
        for (const foto of fotos) {
          const img = document.createElement("img");
          img.src = foto.url;
          img.width = 600;
          img.height = 700;
          const btn = document.createElement("button");
          btn.id = "me-gusta";
          btn.textContent = "Me gusta";

          btn.addEventListener("click", function(event) {
            event.target.classList.toggle('liked');
            console.log('Se ha dado me gusta a la foto');
            const fotoUrl = event.target.parentNode.firstChild.src;

              fetch(`https://${apiIP}:3000/like`, { // Add the Access-Control-Allow-Origin header
                method: 'POST',
                headers: {
                  'Content-Type': 'application/json',
                },
                body: JSON.stringify({ url: fotoUrl }),
              })
              .then(response => {
                if (response.ok) {
                  console.log('Like sent successfully');
                } else {
                  console.log('Failed to send like');
                }
              })
              .catch(error => {
                console.log('Error occurred while sending like:', error);
              });
            });

  
          const div = document.createElement("div");
          div.className = "publicacion";
          div.appendChild(img);
          div.appendChild(btn);
  
          document.getElementById("feed").appendChild(div);
        }
      }
    };
  
    xhr.send();
}

function ver_guardados() {
  window.location.href = "guardados.html";
}
document.getElementById("ver-guardados").addEventListener("click", ver_guardados);
getPhotos();


