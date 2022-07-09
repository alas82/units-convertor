unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, StdConvs, ConvUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure changefamily(Sender: TObject);

  private
    fam: TConvFamily;          //we define var as tconvfamily
    fams: TConvFamilyArray;     // we define an array to get all fmilies
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  len: integer;
begin
  GetConvFamilies(fams);      //we load all families in combobox we return array
  Len := Length(Fams); //we measure the length of the array
  if (Len <> 0) then          //if not o we continue

    for len := Low(Fams) to High(Fams) do //we loop in array the load it to combo
      //ComboBox1.Items.Add(format('%d: %s',[ord(fam),ConvFamilyToDescription(fam)]));
      ComboBox1.Items.Add(format('%s', [ConvFamilyToDescription(len)]));
  ComboBox1.ItemIndex := 0;
  changefamily(self);//we load the units description in listbox
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  changefamily(self);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  BaseType, DestType: TConvType;
begin
  DescriptionToConvType(fam, ListBox1.Items[listbox1.ItemIndex], BaseType); //we return the description to atype    we save it in bassetype
  DescriptionToConvType(fam, ListBox2.Items[listbox2.ItemIndex], DestType);
  label1.Caption := FloatToStr(Convert(StrToFloat(edit1.Text), BaseType, DestType));  //we use convert to get the convertion
end;

procedure TForm1.changefamily(Sender: TObject);
var
  atypes: TConvTypeArray;//we define array for types
  i: integer;
begin
  //fggf
  ListBox1.Clear;    //clear the list box
  ListBox2.Clear;
  fam := fams[ComboBox1.ItemIndex]; //return the family of the description
  GetConvTypes(fam, atypes);  //we save the type of the family in the rray  of types
  for i in atypes do          // we loop in the array to load it in listbox
  begin
    ListBox1.Items.Add(ConvTypeToDescription(i));//we convert the atypeitem to description
  end;
  ListBox1.ItemIndex := 0;
  i := 0;
  for i in atypes do
  begin
    ListBox2.Items.Add(ConvTypeToDescription(i));
  end;
  ListBox2.ItemIndex := 0;
end;



end.
