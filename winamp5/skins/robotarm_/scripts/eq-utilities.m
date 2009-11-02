/************************************************************

	KameleonDIU - eq-utilities.m
	by Leechbite

	- Equalizer Utilities scripts

***********************************************************/
#ifndef TRUE

#define TRUE 1
#define FALSE 0

#endif

#define EQ_Rock 1,49,29,-39,-55,-27,25,57,69,69,69
#define EQ_Full 1,45,37,1,-51,-35,9,53,69,77,77
#define EQ_Pop 1,-15,29,45,49,33,-11,-19,-19,-15,-15
#define EQ_Soft 1,29,9,-11,-19,-11,25,53,61,69,77
#define EQ_Techno 1,49,37,1,-39,-35,1,49,61,61,57
#define EQ_Reggae 1,1,1,-7,-43,1,41,41,1,1,1
#define EQ_Classical 1,1,1,1,1,1,1,-51,-51,-51,-67
#define EQ_Dance 1,61,45,13,-3,-3,-43,-51,-51,-3,-3
#define EQ_Ska 1,-19,-35,-31,-7,25,37,57,61,69,61
#define EQ_SoftRock 1,25,25,13,-7,-31,-39,-27,-7,17,57
#define EQ_Flat 1,1,1,1,1,1,1,1,1,1,1


function boolean isEQEqualTo(int preamp, int eq0, int eq1, int eq2, int eq3, 
	int eq4, int eq5, int eq6, int eq7, int eq8, int eq9); 

function setEQPreset(int preamp, int eq0, int eq1, int eq2, int eq3, 
	int eq4, int eq5, int eq6, int eq7, int eq8, int eq9); 

function setEQPresetUSER();
function setUSEREQ();

boolean isEQEqualTo(int preamp, int eq0, int eq1, int eq2, int eq3, 
	int eq4, int eq5, int eq6, int eq7, int eq8, int eq9) {
	boolean equal;
	
	if (preamp!=getEQPreamp()) return FALSE;
	if (eq0!=getEQband(0)) return FALSE;
	if (eq1!=getEQband(1)) return FALSE;
	if (eq2!=getEQband(2)) return FALSE;
	if (eq3!=getEQband(3)) return FALSE;
	if (eq4!=getEQband(4)) return FALSE;
	if (eq5!=getEQband(5)) return FALSE;
	if (eq6!=getEQband(6)) return FALSE;
	if (eq7!=getEQband(7)) return FALSE;
	if (eq8!=getEQband(8)) return FALSE;
	if (eq9!=getEQband(9)) return FALSE;
	
	return TRUE;
}

setEQPreset(int preamp, int eq0, int eq1, int eq2, int eq3, 
	int eq4, int eq5, int eq6, int eq7, int eq8, int eq9) {

	setEQPreamp(preamp);
	setEQBand(0, eq0);
	setEQBand(1, eq1);
	setEQBand(2, eq2);
	setEQBand(3, eq3);
	setEQBand(4, eq4);
	setEQBand(5, eq5);
	setEQBand(6, eq6);
	setEQBand(7, eq7);
	setEQBand(8, eq8);
	setEQBand(9, eq9);
}

setEQPresetUSER() {
	setEQBand(0, getPrivateInt(getSkinName(), "User EQ 0", getEQBand(0)));
	setEQBand(1, getPrivateInt(getSkinName(), "User EQ 1", getEQBand(1)));
	setEQBand(2, getPrivateInt(getSkinName(), "User EQ 2", getEQBand(2)));
	setEQBand(3, getPrivateInt(getSkinName(), "User EQ 3", getEQBand(3)));
	setEQBand(4, getPrivateInt(getSkinName(), "User EQ 4", getEQBand(4)));
	setEQBand(5, getPrivateInt(getSkinName(), "User EQ 5", getEQBand(5)));
	setEQBand(6, getPrivateInt(getSkinName(), "User EQ 6", getEQBand(6)));
	setEQBand(7, getPrivateInt(getSkinName(), "User EQ 7", getEQBand(7)));
	setEQBand(8, getPrivateInt(getSkinName(), "User EQ 8", getEQBand(8)));
	setEQBand(9, getPrivateInt(getSkinName(), "User EQ 9", getEQBand(9)));
	setEQPreamp(getPrivateInt(getSkinName(), "User EQ Preamp", getEQPreamp()));
	
}

setUSEREQ() {
	setPrivateInt(getSkinName(), "User EQ 0", getEQBand(0));
	setPrivateInt(getSkinName(), "User EQ 1", getEQBand(1));
	setPrivateInt(getSkinName(), "User EQ 2", getEQBand(2));
	setPrivateInt(getSkinName(), "User EQ 3", getEQBand(3));
	setPrivateInt(getSkinName(), "User EQ 4", getEQBand(4));
	setPrivateInt(getSkinName(), "User EQ 5", getEQBand(5));
	setPrivateInt(getSkinName(), "User EQ 6", getEQBand(6));
	setPrivateInt(getSkinName(), "User EQ 7", getEQBand(7));
	setPrivateInt(getSkinName(), "User EQ 8", getEQBand(8));
	setPrivateInt(getSkinName(), "User EQ 9", getEQBand(9));
	setPrivateInt(getSkinName(), "User EQ Preamp", getEQPreamp());
}