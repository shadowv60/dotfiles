/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "JetBrainsMono Nerd Font:size=12" };
static const char dmenufont[]       = "JetBrainsMono Nerd Font:size=12";
/* Wallpaper-matched theme (Bioluminescent Blue) */
static const char col_gray1[] = "#0b1020"; /* Deep navy (background) */
static const char col_gray2[] = "#121a33"; /* Inactive border */
static const char col_gray3[] = "#5fd1e8"; /* Softer Cyan (inactive text) */
/* IMPORTANT: Keep col_gray4 dark so it's readable on the bright blue accent */
static const char col_gray4[] = "#050a14"; /* Dark navy text (active text) */
/* CHANGE THIS LINE: */
static const char col_accent[] = "#00d4ff"; /* Neon Cyan (active accent - root glow) */

static const char *colors[][3]      = {
    /* fg         bg         border   */
    [SchemeNorm] = { col_gray3,  col_gray1,  col_gray2 },
    [SchemeSel]  = { col_gray3,  col_gray1,  col_accent },
};
/* tagging */
static const char *tags[] = { "", "", "3", "󰎄", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
    /* class      instance     title    tags mask  isfloating  monitor */
    { "helium-browser", NULL,   NULL,    1 << 0,    0,          -1 },
    
    /* 1. Specific instances first */
    { "kitty",    "rmpc_term", NULL,    1 << 3,    0,          -1 }, // Tag 4 only
    { "kitty",    "cava_term", NULL,    1 << 3,    0,          -1 }, // Tag 4 only
    
    /* 2. Generic class last */
    /* By leaving instance as NULL here, it acts as a catch-all for any kitty 
       window that didn't match the specific names above. */
    { "kitty",    "kitty",     NULL,    1 << 1,    0,          -1 }, // Tag 2 only
    
    { "Gimp",     NULL,        NULL,    0,         1,          -1 },
    { "Firefox",  NULL,        NULL,    1 << 8,    0,          -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]:",      tile },    /* first entry is default */
	{ "[F]:",      NULL },    /* no layout function means floating behavior */
	{ "[M]:",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define STATUSBAR "dwmblocks" 
#include <X11/XF86keysym.h>
#define CLICKABLE_BLOCKS 1

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_accent, "-sf", col_gray4, "-l", "10", NULL };
static const char *termcmd[]  = { "kitty", NULL };
static const char *bar[] = { "helium-browser", NULL };
static const char *yazicmd[]  = { "kitty", "yazi", NULL };
static const char *dolphincmd[]  = { "dolphin", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
  { MODKEY,                       XK_space,  spawn,          SHCMD("rofi -show run") },
  { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_x,      spawn,          SHCMD("/home/shadow/docker/suwayomi/start-suwayomi-latest.sh") },
	{ MODKEY|ShiftMask,             XK_x,      spawn,          SHCMD("/home/shadow/docker/suwayomi/stop-suwayomi.sh") },
	{ MODKEY,                       XK_b,      spawn,          {.v = bar } },
  /* Find these lines in your keys[] array and update them: */
  { MODKEY,                       XK_m,      spawn,          SHCMD("kitty --name rmpc_term -e rmpc") },
  { MODKEY,                       XK_c,      spawn,          SHCMD("kitty --name cava_term -e cava") },
  { MODKEY,                       XK_f,      spawn,          {.v = yazicmd } },
  { MODKEY,                       XK_F5,     spawn,          SHCMD("redshift -O 3500") },
  { MODKEY|ShiftMask,             XK_F5,     spawn,          SHCMD("redshift -x") },
  { MODKEY|ShiftMask,             XK_f,      spawn,          {.v = dolphincmd } },
	{ MODKEY,                       XK_s,      spawn,          SHCMD("scrot ~/Pictures/%Y-%m-%d-%H%M%S_screenshot.png") },
	{ MODKEY,                       XK_v,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_p,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY,                       XK_z,      zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_Control_L,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_Control_L,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
  { 0, XF86XK_AudioRaiseVolume, spawn,SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ && pkill -RTMIN+10 dwmblocks") },
  { 0, XF86XK_AudioLowerVolume, spawn,SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && pkill -RTMIN+10 dwmblocks") },
  { 0, XF86XK_AudioMute, spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && pkill -RTMIN+10 dwmblocks") },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigstatusbar,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigstatusbar,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigstatusbar,   {.i = 3} },
	{ ClkStatusText,        0,              Button4,        sigstatusbar,   {.i = 4} },
	{ ClkStatusText,        0,              Button5,        sigstatusbar,   {.i = 5} },
	{ ClkStatusText,        0,              6,              sigstatusbar,   {.i = 6} },
	{ ClkStatusText,        0,              7,              sigstatusbar,   {.i = 7} },
	{ ClkStatusText,        0,              8,              sigstatusbar,   {.i = 8} },
	{ ClkStatusText,        0,              9,              sigstatusbar,   {.i = 9} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

