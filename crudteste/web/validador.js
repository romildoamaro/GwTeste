function validar(){
    let email = frmContato.email.value;
    let nome = frmContato.nome.value;
    let cnpj = frmContato.cnpj.value;
    let telefone = frmContato.telefone.value;
    let modal = frmContato.modal.value;
    let rua = frmContato.rua.value;
    let numero = frmContato.numero.value;
    let bairro = frmContato.bairro.value;
    let cidade = frmContato.cidade.value;
    let uf= frmContato.estado.value;

    if (email === "") {
        alert('Preencha o Campo Email');
        frmContato.email.focus();
        return false;
    } else if (nome === "") {
        alert('Prenencha o Campo Nome');
        frmContato.nome.focus;
        return false;
    } else if (cnpj === "") {
        alert('Preencha o Campo Cnpj');
        frmContato.cnpj.focus;
        return false;
    } else if (telefone === "") {
        alert('Preencha o Campo Telefone');
        frmContato.telefone.focus;
        return false;
    } else if (modal === "") {
        alert('Preencha o Campo Modal');
        frmContato.modal.focus;
        return false;
    } else if (rua === "") {
        alert('Preencha o Campo Rua');
        frmContato.rua.focus;
        return false;
    } else if (numero === "") {
        alert('Preencha o Campo Número');
        frmContato.numero.focus;
        return false;
    } else if (bairro === "") {
        alert('Preencha o Campo Bairro');
        frmContato.bairro.focus;
        return false;
    } else if (cidade === "") {
        alert('Preencha o Campo Cidade');
        frmContato.cidade.focus;
        return false;
    } else if (uf === "") {
        alert('Preencha o Campo Estado');
        frmContato.estado.focus;
        return false;
    }else        
        document.forms["frmContato"].submit();       
}
