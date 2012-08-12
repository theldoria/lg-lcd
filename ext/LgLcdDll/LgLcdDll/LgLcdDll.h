// Folgender ifdef-Block ist die Standardmethode zum Erstellen von Makros, die das Exportieren 
// aus einer DLL vereinfachen. Alle Dateien in dieser DLL werden mit dem LGLCDDLL_EXPORTS-Symbol
// (in der Befehlszeile definiert) kompiliert. Dieses Symbol darf für kein Projekt definiert werden,
// das diese DLL verwendet. Alle anderen Projekte, deren Quelldateien diese Datei beinhalten, erkennen 
// LGLCDDLL_API-Funktionen als aus einer DLL importiert, während die DLL
// mit diesem Makro definierte Symbole als exportiert ansieht.
#ifdef LGLCDDLL_EXPORTS
#define LGLCDDLL_API __declspec(dllexport)
#else
#define LGLCDDLL_API __declspec(dllimport)
#endif

/*
// Diese Klasse wird aus LgLcdDll.dll exportiert.
class LGLCDDLL_API CLgLcdDll {
public:
	CLgLcdDll(void);
	// TODO: Hier die Methoden hinzufügen.
};

extern LGLCDDLL_API int nLgLcdDll;

LGLCDDLL_API int fnLgLcdDll(void);
*/