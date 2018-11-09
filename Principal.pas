unit Principal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, StrUtils ;

type
  TfrmPrincipal = class(TForm)
    edtTextoPlano: TEdit;
    edtTextoCriptografado: TEdit;
    btnCriptografar: TBitBtn;
    btnDescriptografar: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    edtChave: TEdit;
    Label3: TLabel;
    procedure btnCriptografarClick(Sender: TObject);
    procedure btnDescriptografarClick(Sender: TObject);
  private
    { Private declarations }
    function SoLetra(ATexto: string): string;
    function Criptografar(ATextoPlano: string; AChave: string): string;
    function Descriptografar(ATextoCriptografado: string; AChave: string): string;
    function Criptografar_Substituicao(ATextoPlano: string; AChave: string): string;
    function Descriptografar_Substituicao(ATextoCriptografado: string; AChave: string): string;
    function Criptografar_Transposicao(ATextoPlano: string): string;
    function Descriptografar_Transposicao(ATextoCriptografado: string): string;

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

procedure TfrmPrincipal.btnCriptografarClick(Sender: TObject);
begin
  edtTextoCriptografado.Text := Criptografar(UpperCase(edtTextoPlano.Text), UpperCase(edtChave.Text));
end;

procedure TfrmPrincipal.btnDescriptografarClick(Sender: TObject);
begin
  edtTextoPlano.Text := Descriptografar(UpperCase(edtTextoCriptografado.Text), UpperCase(edtChave.Text));
end;

function TfrmPrincipal.SoLetra(ATexto: string): string;
var
  I: integer;
  S: string;
begin
  // Metodo criado para retornar somentes as letras do alfabeto de uma string.
  S := '';
  for I := 1 To Length(ATexto) Do
  begin
    if Pos(UpperCase(ATexto[I]), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') > 0 then
    begin
      S := S + Copy(ATexto, I, 1);
    end;
  end;
  Result := S;
end;

function TfrmPrincipal.Criptografar(ATextoPlano, AChave: string): string;
var
  vsTextoCriptogrado: string;
begin
   vsTextoCriptogrado := Criptografar_Substituicao(ATextoPlano, AChave);

   vsTextoCriptogrado := Criptografar_Transposicao(vsTextoCriptogrado);

   Result := vsTextoCriptogrado;
end;

function TfrmPrincipal.Descriptografar(ATextoCriptografado,
  AChave: string): string;
var
  vsTextoPlano: string;
begin
   vsTextoPlano := Descriptografar_Transposicao(ATextoCriptografado);
   vsTextoPlano := DesCriptografar_Substituicao(vsTextoPlano, AChave);
   Result := vsTextoPlano;
end;

function TfrmPrincipal.Criptografar_Substituicao(ATextoPlano: string; AChave: string): string;
var
  vsTextoCifrado, vsAlfabeto, vsAlfabetoAlterado: string;
  Contador: Integer;
begin
  vsAlfabeto := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  vsAlfabetoAlterado := vsAlfabeto;

  //Retirar as letras repetidas na Chave
  for Contador := 1 to Length(AChave) do
  begin
    if Pos(AChave[Contador], AChave) <> Contador then
      Delete(AChave, Contador, Length(AChave));
  end;
  //Retirar do Alfabeto as letras da chave para só adiciona-las no inicio
  for Contador := 1 to Length(AChave) do
  begin
    Delete(vsAlfabetoAlterado, Pos(AChave[Contador], vsAlfabetoAlterado), 1);
  end;
  // Colocar a Chave no Inicio do Alfabeto alterado(Já retirado as letras da chave)
  vsAlfabetoAlterado := AChave + vsAlfabetoAlterado;
  vsTextoCifrado := UpperCase(SoLetra(ATextoPlano));

  // Substituir os caracteres do Texto com o caractere da mesma posicao no alfabeto alterado
  for Contador := 1 to Length(ATextoPlano) do
  begin
    if Pos(vsTextoCifrado[Contador], vsAlfabeto) <> 0 then
      vsTextoCifrado[Contador] := vsAlfabetoAlterado[Pos(vsTextoCifrado[Contador], vsAlfabeto)];
  end;

  Result := vsTextoCifrado;
end;

function TfrmPrincipal.Descriptografar_Substituicao(ATextoCriptografado: string; AChave: string): string;
  var
  vsTextoPlano, vsAlfabeto, vsAlfabetoAlterado: string;
  Contador: Integer;
begin
  vsAlfabeto := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  vsAlfabetoAlterado := vsAlfabeto;

  //Retirar as letras repetidas na Chave
  for Contador := 1 to Length(AChave) do
  begin
    if Pos(AChave[Contador], AChave) <> Contador then
      Delete(AChave, Contador, Length(AChave));
  end;
  //Retirar do Alfabeto as letras da chave para só adiciona-las no inicio
  for Contador := 1 to Length(AChave) do
  begin
    Delete(vsAlfabetoAlterado, pos(AChave[Contador], vsAlfabetoAlterado), 1);
  end;

  vsAlfabetoAlterado := AChave + vsAlfabetoAlterado;
  vsTextoPlano := UpperCase(SoLetra(ATextoCriptografado));

  // Substituir os caracteres do Texto com o caractere da mesma posicao no alfabeto alterado
  for Contador := 1 to Length(ATextoCriptografado) do
  begin
    if Pos(vsTextoPlano[Contador], vsAlfabetoAlterado) <> 0 then
      vsTextoPlano[Contador] := vsAlfabeto[Pos(vsTextoPlano[Contador], vsAlfabetoAlterado)];
  end;

  Result := vsTextoPlano;
end;

function TfrmPrincipal.Criptografar_Transposicao(ATextoPlano: string): string;
var
  vsTextoCifrado, vsAlfabeto, vsAlfabetoExtendido: string;
  viTamanhoTexto,  viQtdCasasAndar, Contador, viRepeticao, viPosicao: Integer;
begin
  vsAlfabeto := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  vsAlfabetoExtendido := vsAlfabeto;

  viTamanhoTexto := Length(ATextoPlano);

  //Pegar a posicao da letra do TextoPlano que tem a maior posicao no alfabeto
  viPosicao := 1;
  for Contador := 1 to viTamanhoTexto do
  begin
    if Pos(ATextoPlano[Contador], vsAlfabeto) > viPosicao then
      viPosicao := Pos(ATextoPlano[Contador], vsAlfabeto);
  end;

  viQtdCasasAndar := viTamanhoTexto mod 26; // 26 é o tamanho do Alfabeto. O resto dessa divisão será a quantidade de casas que o algoritmo vai andar.

  if viQtdCasasAndar = 0 then // Se o Texto tiver o mesmo tamanho do Alfabeto.
    viQtdCasasAndar := 7; //Define um valor padrão.

  //Crescer o Alfabeto Extendido
  if (viPosicao + viQtdCasasAndar) > 26 then // 26 é o tamanho do Alfabeto.
  begin
    viRepeticao := Trunc((viPosicao + viQtdCasasAndar) / 26);
    for Contador := 1 to viRepeticao do
      vsAlfabetoExtendido := vsAlfabetoExtendido + vsAlfabetoExtendido;
  end;

  vsTextoCifrado := UpperCase(SoLetra(ATextoPlano));

  for Contador := 1 to viTamanhoTexto do
  begin
    viPosicao :=  Pos(vsTextoCifrado[Contador], vsAlfabeto) + viQtdCasasAndar;

    vsTextoCifrado[Contador] := vsAlfabetoExtendido[viPosicao];
  end;

  Result := vsTextoCifrado;
end;

function TfrmPrincipal.Descriptografar_Transposicao(ATextoCriptografado: string): string;
var
  vsTextoCifrado, vsAlfabeto, vsAlfabetoExtendido: string;
  viTamanhoTexto,  viQtdCasasAndar, Contador, viRepeticao, viPosicao: Integer;
begin
  vsAlfabeto := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  vsAlfabetoExtendido := vsAlfabeto;

  viTamanhoTexto := Length(ATextoCriptografado);

  //Pegar a posicao da letra do TextoPlano que tem a maior posicao no alfabeto
  viPosicao := 1;
  for Contador := 1 to viTamanhoTexto do
  begin
    if Pos(ATextoCriptografado[Contador], vsAlfabeto) > viPosicao then
      viPosicao := Pos(ATextoCriptografado[Contador], vsAlfabeto);
  end;

  viQtdCasasAndar := viTamanhoTexto mod 26; // 26 é o tamanho do Alfabeto. O resto dessa divisão será a quantidade de casas que o algoritmo vai andar.

  if viQtdCasasAndar = 0 then // Se o Texto tiver o mesmo tamanho do Alfabeto.
    viQtdCasasAndar := 7; //Define um valor padrão.

  //Crescer o Alfabeto Extendido
  if (viPosicao + viQtdCasasAndar) > 26 then // 26 é o tamanho do Alfabeto.
  begin
    viRepeticao := Trunc((viPosicao + viQtdCasasAndar) / 26);
    for Contador := 1 to viRepeticao do
      vsAlfabetoExtendido := vsAlfabetoExtendido + vsAlfabetoExtendido;
  end;

  vsTextoCifrado := UpperCase(SoLetra(ATextoCriptografado));

  for Contador := 1 to viTamanhoTexto do
  begin
    viPosicao := Pos(vsTextoCifrado[Contador], vsAlfabetoExtendido) - viQtdCasasAndar;
    if viPosicao < 0 then
      viPosicao := viPosicao + 26;

    vsTextoCifrado[Contador] := vsAlfabeto[viPosicao];
  end;

  Result := vsTextoCifrado;
end;

end.
