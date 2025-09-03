typedef struct _KmMenu {        /*                                         */ __
  struct _KmMenu *next;         /* link to next menu                       */ __
  struct _KmMenu *down;         /* link to submenu                         */ __
  char         *path;           /* path of parent menu                     */ __
  char         *name;           /* menu name                               */ __
  int           level;          /* depth of submenus                       */ __
  KmCommand    *cmds;           /* link to first command                   */ __
  int          nguidance;       /* number of lines in guidance text        */ __
  char        **guidance;       /* help text                               */ __
  int          nkeyword;        /* number of lines for keywords            */ __
  char        **keyword;        /* list of keywords                        */ __
  int          nhlink;          /* number of lines for links               */ __
  char        **hlink;          /* list of links                           */ __
} KmMenu;                       /*                                         */ __
                                /*                                         */ __
/*
extern void klnkbrcl(); 
extern void klnkicon(); 
extern void klnkkmcl();
extern void klnkmenu();
*/
struct _BrClass;
struct _KmClass;
struct _KmIcon;
struct _KmButton;
extern void  klnkbrcl( struct _BrClass*, int );
extern void  klnkkmcl( struct _KmClass*, int );
extern void  klnkicon( struct _KmIcon*, int );
extern void  klnkbutt( struct _KmButton*, int );
