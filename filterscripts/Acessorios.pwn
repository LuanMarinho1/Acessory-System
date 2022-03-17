/**********************************************************************************************/
// Sistema de Acessórios 1.0 - By Dath. https://github.com/LuanMarinho1/Sistema-de-Acessorios //
/**********************************************************************************************/
#include <a_samp>
#include <zcmd>
#include <sscanf2>
#include <DOF2>
#include <PreviewModelDialog>

#define DialogSlots 150
#define DialogLocais 151
#define DialogAcessorios 152
#define DialogEditRemove 153

#define MAX_SLOTS 10
#define MAX_ACESSORIOS 289
#define PastaAcessorios "Acessorios/%s%d.ini"

new Slots[MAX_PLAYERS], Locais[MAX_PLAYERS];

enum TObject {ObjectModel}
new Acessorios[][TObject] =
{
	1265, 19078, 18632, 18633, 18634, 18635, 18636, 18637, 18638, 18639, 18640, 18975, 19136, 19274, 18641, 18642, 18643, 19080, 19081, 19082, 19083, 19084, 18644, 18645, 18865, 18866, 18867, 18868, 18869, 18870, 18871, 18872, 18873, 18874, 18875, 18890, 18891, 18892, 18893, 18894, 18895, 18896, 18897, 18898, 18899, 18900,
	18901, 18902, 18903, 18904, 18905, 18906, 18907, 18908, 18909, 18910, 18911, 18912, 18913, 18914, 18915, 18916, 18917, 18918, 18919, 18920, 18921, 18922, 18923, 18924, 18925, 18926, 18927, 18928, 18929, 18930, 18931, 18932, 18933, 18934, 18935, 18936, 18937, 18938, 18939, 18940, 18941, 18942, 18943, 18944,
	18945, 18946, 18947, 18948, 18949, 18950, 18951, 18952, 18953, 18954, 18955, 18956, 18957, 18958, 18959, 18960, 18961, 18962, 18963, 18964, 18965, 18966, 18967, 18968, 18969, 18970, 18971, 18972, 18973, 18974, 18976, 18977, 18978, 18979, 19006, 19007, 19008, 19009, 19010, 19011, 19012, 19013, 19014, 19015,
	19016, 19017, 19018, 19019, 19020, 19021, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19033, 19034, 19035, 19036, 19037, 19038, 19039, 19040, 19041, 19042, 19043, 19044, 19045, 19046, 19047, 19048, 19049, 19050, 19051, 19052, 19053, 19085, 19086, 19090, 19091, 19092, 19093,
	19094, 19095, 19096, 19097, 19098, 19099, 19100, 19101, 19102, 19103, 19104, 19105, 19106, 19107, 19108, 19109, 19110, 19111, 19112, 19113, 19114, 19115, 19116, 19117, 19118, 19119, 19120, 19137, 19138, 19139, 19140, 19141, 19142, 19160, 19161, 19162, 19163, 19317, 19318, 19319, 19330, 19331, 19346, 19347,
	19348, 19349, 19350, 19351, 19352, 19487, 19488, 19513, 19578, 19418, 19274, 19515, 16442, 1518, 1371, 3524, 1985, 2918, 2780, 1238, 3070, 2045, 1225, 1654, 3528, 331, 333, 334, 335, 336, 337, 338, 339, 341, 321, 322, 323, 324, 325, 326, 343, 346, 347, 348, 349, 350, 351, 352, 353, 355, 356, 372, 357,
 	358, 361, 363, 364, 365, 366, 367, 368, 369, 371, 354, 1317, 1559, 1317
};

CMD:acessorios(playerid)
{
	new String[250];
	for(new i = 0; i < MAX_SLOTS; i++)
    {
        if(IsPlayerAttachedObjectSlotUsed(playerid, i))
        {
            format(String, sizeof(String), "%s{FFFFFF}» Slot %d - {00FF00}Em Uso\n", String, i);
		}
		else format(String, sizeof(String), "%s{FFFFFF}» Slot %d\n", String, i);
    }
	ShowPlayerDialog(playerid, DialogSlots, DIALOG_STYLE_LIST, "Escolha um slot:", String, "Selecionar", "Cancelar");
	return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DialogSlots)
	{
	    if(!response) return 1;
	    Slots[playerid] = listitem;
 		if(IsPlayerAttachedObjectSlotUsed(playerid, listitem)) return ShowPlayerDialog(playerid, DialogEditRemove, DIALOG_STYLE_LIST, "* Acessorios - Editar ou remover", "Editar objeto\n{FF0000}Remover Objeto", "Selecionar", "Cancelar");
 		ShowPlayerDialog(playerid, DialogLocais, DIALOG_STYLE_LIST, "Escolha o local do corpo:", "Coluna\nCabeça\nBraço esquerdo\nBraço direito\nMão esquerda\nMão direita\nCoxa esquerdo\nCoxa direita\nPé esquerda\nPé direito\nPanturrilha direita\nPanturrilha esquerda\nAntebraço esquerdo\nAntebraço direito\nOmbro esquerdo\nOmbro direito\nPescoço\nMandíbula", "Selecionar", "Cancelar");
	}
	if(dialogid == DialogEditRemove)
	{
		if(!response) return 1;
  		if(listitem == 0) EditAttachedObject(playerid, Slots[playerid]);
		if(listitem == 1) DOF2_RemoveFile(Get(playerid)), RemovePlayerAttachedObject(playerid, Slots[playerid]);
	}
	if(dialogid == DialogLocais)
	{
		if(!response) return 1;
        Locais[playerid] = listitem+1, Objetos(playerid);
	}
	if(dialogid == DialogAcessorios)
	{
		if(!response) return 1;
		SetPlayerAttachedObject(playerid, Slots[playerid], Acessorios[listitem][ObjectModel], Locais[playerid], 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0), EditAttachedObject(playerid, Slots[playerid]);
	}
	return 1;
}
public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    if(response)
    {
        new String[50];
        format(String, sizeof String, PastaAcessorios, Nome(playerid), index);
	    if(!DOF2::FileExists(String)) { DOF2::CreateFile(String); }
		DOF2_SetInt(String, "Modelid", modelid), DOF2_SetInt(String, "Boneid", boneid);
		DOF2_SetFloat(String, "OffX", fOffsetX), DOF2_SetFloat(String, "OffY", fOffsetY), DOF2_SetFloat(String, "OffZ", fOffsetZ);
		DOF2_SetFloat(String, "RotX", fRotX), DOF2_SetFloat(String, "RotY", fRotY), DOF2_SetFloat(String, "RotZ", fRotZ);
		DOF2_SetFloat(String, "ScaleX", fScaleX), DOF2_SetFloat(String, "ScaleY", fScaleY), DOF2_SetFloat(String, "ScaleZ", fScaleZ), DOF2::SaveFile();
	}
	else EditAttachedObject(playerid, index);
    return 1;
}
public OnPlayerSpawn(playerid)
{
    for(new i = 0; i < MAX_SLOTS; i++)
    {
        new String[28];
        format(String, sizeof(String), PastaAcessorios, Nome(playerid), i);
	    if(DOF2::FileExists(String)) {SetPlayerAttachedObject(playerid, i, DOF2_GetInt(String, "Modelid"), DOF2_GetInt(String, "Boneid"), DOF2_GetFloat(String, "OffX"), DOF2_GetFloat(String, "OffY"), DOF2_GetFloat(String, "OffZ"), DOF2_GetFloat(String, "RotX"), DOF2_GetFloat(String, "RotY"), DOF2_GetFloat(String, "RotZ"), DOF2_GetFloat(String, "ScaleX"), DOF2_GetFloat(String, "ScaleY"), DOF2_GetFloat(String, "ScaleZ"), 0, 0);}
	}
    return 1;
}
stock Objetos(playerid)
{
    new String[24000];
	for(new i = 0; i < MAX_ACESSORIOS; i++)
	{
		format(String, sizeof(String), "%s%i\n", String, Acessorios[i][ObjectModel]);
	}
	ShowPlayerDialog(playerid, DialogAcessorios, DIALOG_STYLE_PREVIEW_MODEL, "Acessorios", String, "SELECIONAR", "CANCELAR");
	return 1;
}
stock Nome(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}
stock Get(playerid)
{
    new Arq[40];
    format(Arq, sizeof Arq, PastaAcessorios, Nome(playerid), Slots[playerid]);
    return Arq;
}
