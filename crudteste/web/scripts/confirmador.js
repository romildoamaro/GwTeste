//function confirmar() {
//    
//    var resultado = confirm("Confirmar Exclusão?");
//    if(resultado === true) {
//        alert("Excluido Com Sucesso!");
//    }else{
//        document.getElementById('deletar').href="";
//        alert("Exlusão Não Concluida");
//    }
//
//}

function confirmar(id){
    let resposta = confirm("Confirmar Exclusão?");
    if (resposta === true){
        alert(id);
        window.location.href = "delete?id=" + id;
    }
}