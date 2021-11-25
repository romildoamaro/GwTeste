
<!DOCTYPE html>
<%@page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html lang="pt-br">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="img/truck.png"/>
        <!--        <link rel="stylesheet" href="style.css"/>-->
        <title>Cadastrar</title>
        <style>
            body {
                background-color: white;
                max-width: 940px;
                min-width: 720px;
                margin: 10px auto 10px auto;
                padding: 20px;
            }

            .frm {
                margin: auto;
                /*                width: 300px;
                                padding: 50px;
                                border: 20px;*/
            }

        </style>
    </head>
    <body>
        <h1>Cadastrar</h1>
        <div class="cadastrar-form"">
            <form class="frm" name="frmContato" action="/crudteste/inserir" method="get"> 
                <table>
                    <tr>
                        <td>Nome:</td>
                        <td><input required type="text" name="nome" id="nome"></td>
                    </tr>
                    <tr>
                        <td>Email:</td>
                        <td><input required type="email" name="email" id="email"></td>
                    </tr>
                    <tr>
                        <td>Cnpj:</td>
                        <td><input  required type="text" name="cnpj" id="cnpj"></td>
                    </tr>
                    <tr>
                        <td>Telefone:</td>
                        <td><input required type="text" name="telefone" id="telefone"> </td>
                    </tr>
                    <tr>
                        <td>Celular:</td>
                        <td><input type="text" name="celular" id="celular"></td>
                    </tr> 
                    <tr>
                        <td>Whatsapp:</td>
                        <td><input type="text" name="whatsapp" id="whatsapp"></td>
                    </tr>
                    <tr>
                        <td>Modal: </td>
                        <td>
                            <select name="modal">
                                <option>Rodoviario</option>
                                <option>Aquaviario</option>
                                <option>Aereo</option>                            
                                <option>Outro</option>
                            </select>
                        </td>
                    <tr>
                        <td>Cep:</td>
                        <td><input type="text" name="cep" maxlength="9" id="cep"></td>
                        <td><input onclick="endereco()" value="Consultar CEP" type="readonly"></td>
                    </tr>
                    <tr>
                        <td>Estado:</td>
                        <td>
                            <select required name="estado">
                                <option value="Selecione">Selecione</option>
                                <option value="AC">Acre</option>
                                <option value="AL">Alagoas</option>
                                <option value="AP">Amapá</option>
                                <option value="AM">Amazonas</option>
                                <option value="BA">Bahia</option>
                                <option value="CE">Ceará</option>
                                <option value="DF">Distrito Federal</option>
                                <option value="ES">Espírito Santo</option>
                                <option value="GO">Goiás</option>
                                <option value="MA">Maranhão</option>
                                <option value="MT">Mato Grosso</option>
                                <option value="MS">Mato Grosso do Sul</option>
                                <option value="MG">Minas Gerais</option>
                                <option value="PA">Pará</option>
                                <option value="PB">Paraíba</option>
                                <option value="PR">Paraná</option>
                                <option value="PE">Pernambuco</option>
                                <option value="PI">Piauí</option>
                                <option value="RJ">Rio de Janeiro</option>
                                <option value="RN">Rio Grande do Norte</option>
                                <option value="RS">Rio Grande do Sul</option>
                                <option value="RO">Rondônia</option>
                                <option value="RR">Roraima</option>
                                <option value="SC">Santa Catarina</option>
                                <option value="SP">São Paulo</option>
                                <option value="SE">Sergipe</option>
                                <option value="TO">Tocantins</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Cidade:</td>
                        <td><input required type="text" name="cidade" id="localidade"></td>
                    </tr>
                    <tr>
                        <td>Bairro:</td>
                        <td><input required type="text" name="bairro" id="bairro"></td>
                    </tr>
                    <tr>
                        <td>Rua:</td>
                        <td><input required type="text" name="rua" id="logradouro"></td>
                    </tr>
                    <tr>
                        <td>Número:</td>
                        <td><input required type="text" name="numero" id="numero"></td>
                    </tr>

                    <tr>                    
                    </tr>                
                </table>
                <input required type="checkbox" id="termos" name="termos">
                <label for="termos">Li e Aceito os Termos de Serviço</label>
                <table>
                    <td colspan="2">
                        <input type="submit" value="Cadastre-se Agora!" class="Cadastrar" onclick="validar()">
                    </td>        
                </table>
            </form>
        </div>
        <a href="lista">Voltar</a>
        <!--        <script type="text/javascript" src="validador.js"></script>-->

        <script>
            function endereco() {
                var cep = document.getElementById("cep");
//            alert(cep.value);
                var url = "http://viacep.com.br/ws/" + cep.value + "/json/";

                var localidade = document.getElementById("localidade");
                var bairro = document.getElementById("bairro");
                var logradouro = document.getElementById("logradouro");

                fetch(url, {method: 'GET'})
                        .then(response => {
                            response.json()
                                    .then(data => {
//                            console.log(data);
                                        localidade.value = data.localidade;
                                        bairro.value = data.bairro;
                                        logradouro.value = data.logradouro;
                                    });
                        });
            }
        </script>
        <!--        <script>
                    function validar() {
                        let email = frmContato.email.value;
                        let nome = frmContato.nome.value;
                        let cnpj = frmContato.cnpj.value;
                        let telefone = frmContato.telefone.value;
                        let modal = frmContato.modal.value;
                        let rua = frmContato.rua.value;
                        let numero = frmContato.numero.value;
                        let bairro = frmContato.bairro.value;
                        let cidade = frmContato.cidade.value;
                        let uf = frmContato.estado.value;
        
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
                        } else {
                            document.forms["frmContato"].submit();
                        }    
                }
                    
                </script>-->
    </body>
</html>
