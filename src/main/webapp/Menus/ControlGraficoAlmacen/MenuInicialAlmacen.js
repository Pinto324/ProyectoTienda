const menu = document.getElementById('menuReportes');
const menuDesplegable = document.querySelector('.menuDesplegable');

menu.addEventListener('click',()=>{
    menu.classList.toggle('active');
    menuDesplegable.classList.toggle('click');
})