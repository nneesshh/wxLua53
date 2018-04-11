// ===========================================================================
// Purpose:     enums, defines from wx/defs.h and other places
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

#include "wx/defs.h"
#include "wx/utils.h"

// This list of global functions is taken from the wxWindow's manual

// ---------------------------------------------------------------------------
// Application initialization and termination

void wxInitAllImageHandlers();
bool wxSafeYield(wxWindow* win = NULL, bool onlyIfNeeded = false);
bool wxYield();
void wxWakeUpIdle();

// ---------------------------------------------------------------------------
// wxProcess

#if wxLUA_USE_wxProcess

enum
{
    wxEXEC_ASYNC,
    wxEXEC_SYNC,
    wxEXEC_NOHIDE,
    wxEXEC_MAKE_GROUP_LEADER,
    wxEXEC_NODISABLE
};

enum
{
    wxPROCESS_DEFAULT,
    wxPROCESS_REDIRECT
};

enum wxSignal
{
    wxSIGNONE,
    wxSIGHUP,
    wxSIGINT,
    wxSIGQUIT,
    wxSIGILL,
    wxSIGTRAP,
    wxSIGABRT,
    wxSIGEMT,
    wxSIGFPE,
    wxSIGKILL,
    wxSIGBUS,
    wxSIGSEGV,
    wxSIGSYS,
    wxSIGPIPE,
    wxSIGALRM,
    wxSIGTERM
};

enum wxKillError
{
    wxKILL_OK,
    wxKILL_BAD_SIGNAL,
    wxKILL_ACCESS_DENIED,
    wxKILL_NO_PROCESS,
    wxKILL_ERROR
};

enum wxKillFlags
{
    wxKILL_NOCHILDREN,
    wxKILL_CHILDREN
};

class %delete wxProcess : public wxEvtHandler
{
    wxProcess(wxEvtHandler *parent = NULL, int nId = wxID_ANY);
    wxProcess(int flags);
    %win bool Activate() const;
    wxUSE_STREAMS void CloseOutput();
    void Detach();
    static bool Exists(int pid);
    wxUSE_STREAMS wxInputStream *GetErrorStream() const;
    wxUSE_STREAMS wxInputStream *GetInputStream() const;
    wxUSE_STREAMS wxOutputStream *GetOutputStream() const;
    long GetPid() const;
    wxUSE_STREAMS bool IsErrorAvailable() const;
    wxUSE_STREAMS bool IsInputAvailable() const;
    wxUSE_STREAMS bool IsInputOpened() const;
    static wxKillError Kill(int pid, wxSignal sig = wxSIGTERM, int flags = wxKILL_NOCHILDREN);
    // void OnTerminate(int pid, int status); // just handle the event instead
    static wxProcess *Open(const wxString& cmd, int flags = wxEXEC_ASYNC);
    void Redirect();
    bool IsRedirected(); // %add missing in the interface
    void SetPriority(unsigned int priority); // %override parameter type -- unsigned => unsigned int -- as wxlua doesn't handle "unsigned" by itself
    wxUSE_STREAMS void SetPipeStreams(wxInputStream *outStream, wxOutputStream *inStream, wxInputStream *errStream); // %add missing in the interface
};

#endif //wxLUA_USE_wxProcess

// ---------------------------------------------------------------------------
// Process control functions

long wxExecute(const wxString& command, int flags = wxEXEC_ASYNC, wxProcess *process = NULL);
// %override [long, Lua table of output strings] wxExecuteStdout(const wxString& command, int flags = 0);
%rename wxExecuteStdout long wxExecute(const wxString& command, wxArrayString& output, int flags = 0);
// %override [long, Lua table of output strings, Lua table of error strings] wxExecuteStdoutStderr(const wxString& command, int flags = 0);
%rename wxExecuteStdoutStderr long wxExecute(const wxString& command, wxArrayString& output, wxArrayString& errors, int flags = 0);
void wxExit();

// %override [int, wxKillError rc] wxKill(long pid, wxSignal sig = wxSIGTERM, int flags = 0);
// C++ Func: int wxKill(long pid, wxSignal sig = wxSIGTERM, wxKillError *rc = NULL, int flags = 0);
int wxKill(long pid, wxSignal sig = wxSIGTERM, int flags = 0);
unsigned long wxGetProcessId();
bool wxShell(const wxString& command = "");


enum wxShutdownFlags
{
    wxSHUTDOWN_POWEROFF,
    wxSHUTDOWN_REBOOT
};

bool wxShutdown(wxShutdownFlags flags);

// ---------------------------------------------------------------------------
// File functions - see file.i

// ---------------------------------------------------------------------------
// Network, user, and OS functions - see wxbase_base.i

// ---------------------------------------------------------------------------
// String functions - nothing useful here

// ---------------------------------------------------------------------------
// Dialog functions - see dialogs.i

// ---------------------------------------------------------------------------
// Math functions - nothing useful here

// ---------------------------------------------------------------------------
// GDI functions

// %override [int x, int y, int width, int height] wxClientDisplayRect();
// void wxClientDisplayRect(int *x, int *y, int *width, int *height);
void wxClientDisplayRect();

wxRect wxGetClientDisplayRect();
bool wxColourDisplay();
int wxDisplayDepth();
// %override [int width, int height] wxDisplaySize();
// void wxDisplaySize(int *width, int *height);
void wxDisplaySize();

wxSize wxGetDisplaySize();
// %override [int width, int height] wxDisplaySizeMM();
// void wxDisplaySizeMM(int *width, int *height);
void wxDisplaySizeMM();

wxSize wxGetDisplaySizeMM();

void wxSetCursor(const wxCursor &cursor);
// wxIconOrCursor wxDROP_ICON(wxString name);

// ---------------------------------------------------------------------------
// Printer settings - are marked obsolete

// ---------------------------------------------------------------------------
// Clipboard functions - are marked obsolete

// ---------------------------------------------------------------------------
// Miscellaneous functions

bool wxGetKeyState(wxKeyCode key);
long wxNewId();
void wxRegisterId(long id);
void wxEnableTopLevelWindows(bool enable = true);
int wxFindMenuItemId(wxFrame *frame, const wxString& menuString, const wxString& itemString);
wxWindow* wxFindWindowByLabel(const wxString& label, wxWindow *parent=NULL);
wxWindow* wxFindWindowByName(const wxString& name, wxWindow *parent=NULL);
wxWindow* wxFindWindowAtPoint(const wxPoint& pt);
wxWindow* wxFindWindowAtPointer(wxPoint& pt);
wxWindow* wxGetActiveWindow();
wxPoint wxGetMousePosition();

class wxKeyboardState
{
    wxKeyboardState(bool controlDown = false, bool shiftDown = false, bool altDown = false, bool metaDown = false);
    int GetModifiers() const;
    bool HasAnyModifiers() const;
    bool HasModifiers() const;
    bool ControlDown() const;
    bool RawControlDown() const;
    bool ShiftDown() const;
    bool MetaDown() const;
    bool AltDown() const;
    bool CmdDown() const;
    void SetControlDown(bool down);
    void SetRawControlDown(bool down);
    void SetShiftDown(bool down);
    void SetAltDown(bool down);
    void SetMetaDown(bool down);
};

class %delete wxMouseState : public wxKeyboardState
{
    wxMouseState();
    wxCoord     GetX();
    wxCoord     GetY();
    // void GetPosition(int *x, int *y) const; // skip as this requires override
    bool LeftIsDown() const;
    bool MiddleIsDown() const;
    bool RightIsDown() const;
    %rename LeftDown bool LeftIsDown() const; // for compatibility with previous wxlua versions
    %rename MiddleDown bool MiddleIsDown() const; // for compatibility with previous wxlua versions
    %rename RightDown bool RightIsDown() const; // for compatibility with previous wxlua versions
    bool Aux1IsDown() const;
    bool Aux2IsDown() const;
    void        SetX(wxCoord x);
    void        SetY(wxCoord y);
    void SetPosition(wxPoint pos);
    void        SetLeftDown(bool down);
    void        SetMiddleDown(bool down);
    void        SetRightDown(bool down);
    void        SetAux1Down(bool down);
    void        SetAux2Down(bool down);
    void        SetState(const wxMouseState& state);
};

wxMouseState wxGetMouseState();

// bool wxGetResource(const wxString& section, const wxString& entry, const wxString& *value, const wxString& file = "");
// bool wxWriteResource(const wxString& section, const wxString& entry, const wxString& value, const wxString& file = "");
// wxString  wxGetStockLabel(wxWindowID id, bool withCodes = true, wxString accelerator = wxEmptyString);
wxWindow* wxGetTopLevelParent(wxWindow *win);
bool wxLaunchDefaultBrowser(const wxString& sUrl);
//%win wxString wxLoadUserResource(const wxString& resourceName, const wxString& resourceType="TEXT");
void wxPostEvent(wxEvtHandler *dest, wxEvent& event);

// ---------------------------------------------------------------------------
// Byte order macros - nothing useful

// ---------------------------------------------------------------------------
// RTTI functions - nothing useful, see wxObject:DynamicCast

// ---------------------------------------------------------------------------
// Log functions - FIXME maybe useful?

// ---------------------------------------------------------------------------
// Time functions - see datetime.i

// ---------------------------------------------------------------------------
// Debugging macros and functions - nothing useful

// ---------------------------------------------------------------------------
// Environmental access functions - see wxbase_base.i

// ---------------------------------------------------------------------------
// wxWidgets window IDs - copied from wx/defs.h

#if wxLUA_USE_wxID_XXX

#define wxID_NONE
#define wxID_SEPARATOR
#define wxID_ANY
#define wxID_LOWEST

#define wxID_OPEN
#define wxID_CLOSE
#define wxID_NEW
#define wxID_SAVE
#define wxID_SAVEAS
#define wxID_REVERT
#define wxID_EXIT
#define wxID_UNDO
#define wxID_REDO
#define wxID_HELP
#define wxID_PRINT
#define wxID_PRINT_SETUP
#define wxID_PAGE_SETUP
#define wxID_PREVIEW
#define wxID_ABOUT
#define wxID_HELP_CONTENTS
#define wxID_HELP_INDEX
#define wxID_HELP_SEARCH
#define wxID_HELP_COMMANDS
#define wxID_HELP_PROCEDURES
#define wxID_HELP_CONTEXT
#define wxID_CLOSE_ALL
#define wxID_PREFERENCES

#define wxID_EDIT
#define wxID_CUT
#define wxID_COPY
#define wxID_PASTE
#define wxID_CLEAR
#define wxID_FIND
#define wxID_DUPLICATE
#define wxID_SELECTALL
#define wxID_DELETE
#define wxID_REPLACE
#define wxID_REPLACE_ALL
#define wxID_PROPERTIES

#define wxID_VIEW_DETAILS
#define wxID_VIEW_LARGEICONS
#define wxID_VIEW_SMALLICONS
#define wxID_VIEW_LIST
#define wxID_VIEW_SORTDATE
#define wxID_VIEW_SORTNAME
#define wxID_VIEW_SORTSIZE
#define wxID_VIEW_SORTTYPE

#define wxID_FILE
#define wxID_FILE1
#define wxID_FILE2
#define wxID_FILE3
#define wxID_FILE4
#define wxID_FILE5
#define wxID_FILE6
#define wxID_FILE7
#define wxID_FILE8
#define wxID_FILE9

#define wxID_OK
#define wxID_CANCEL
#define wxID_APPLY
#define wxID_YES
#define wxID_NO
#define wxID_STATIC
#define wxID_FORWARD
#define wxID_BACKWARD
#define wxID_DEFAULT
#define wxID_MORE
#define wxID_SETUP
#define wxID_RESET
#define wxID_CONTEXT_HELP
#define wxID_YESTOALL
#define wxID_NOTOALL
#define wxID_ABORT
#define wxID_RETRY
#define wxID_IGNORE
#define wxID_ADD
#define wxID_REMOVE

#define wxID_UP
#define wxID_DOWN
#define wxID_HOME
#define wxID_REFRESH
#define wxID_STOP
#define wxID_INDEX

#define wxID_BOLD
#define wxID_ITALIC
#define wxID_JUSTIFY_CENTER
#define wxID_JUSTIFY_FILL
#define wxID_JUSTIFY_RIGHT
#define wxID_JUSTIFY_LEFT
#define wxID_UNDERLINE
#define wxID_INDENT
#define wxID_UNINDENT
#define wxID_ZOOM_100
#define wxID_ZOOM_FIT
#define wxID_ZOOM_IN
#define wxID_ZOOM_OUT
#define wxID_UNDELETE
#define wxID_REVERT_TO_SAVED

#define wxID_SYSTEM_MENU
#define wxID_CLOSE_FRAME
#define wxID_MOVE_FRAME
#define wxID_RESIZE_FRAME
#define wxID_MAXIMIZE_FRAME
#define wxID_ICONIZE_FRAME
#define wxID_RESTORE_FRAME

// #define wxID_FILEDLGG - probably not useful

#define wxID_HIGHEST

#endif //wxLUA_USE_wxID_XXX

// ---------------------------------------------------------------------------
// Generic defines and enums

#define wxBACKINGSTORE
#define wxCOLOURED
//#define wxED_BUTTONS_BOTTOM  // for wxExtDialog? not used?
//#define wxED_BUTTONS_RIGHT
//#define wxED_CLIENT_MARGIN
//#define wxED_STATIC_LINE
#define wxFIXED_LENGTH
#define wxNO_BORDER

// #define wxPASSWORD %wxcompat_2_6 use wxTE_PASSWORD
// #define wxPROCESS_ENTER %wxcompat_2_6 use wxTE_PROCESS_ENTER

// #define wxRESIZE_BOX %wxcompat_2_6 use wxMAXIMIZE_BOX
#define wxRETAINED

#define wxSIZE_ALLOW_MINUS_ONE
#define wxSIZE_AUTO
#define wxSIZE_AUTO_HEIGHT
#define wxSIZE_AUTO_WIDTH
#define wxSIZE_NO_ADJUSTMENTS
#define wxSIZE_USE_EXISTING
//#define wxUSER_COLOURS deprecated use wxNO_3D %wxcompat_2_6

/*  ---------------------------------------------------------------------------- */
/*  Geometric flags */
/*  ---------------------------------------------------------------------------- */

enum wxGeometryCentre
{
    wxCENTRE,
    wxCENTER
};

/*  centering into frame rather than screen (obsolete) */
#define wxCENTER_FRAME
/*  centre on screen rather than parent */
#define wxCENTRE_ON_SCREEN
#define wxCENTER_ON_SCREEN

enum wxOrientation
{
    /* don't change the values of these elements, they are used elsewhere */
    wxHORIZONTAL,
    wxVERTICAL,

    wxBOTH,

    /*  a mask to extract orientation from the combination of flags */
    wxORIENTATION_MASK
};

enum wxDirection
{
    wxLEFT,
    wxRIGHT,
    wxUP,
    wxDOWN,

    wxTOP,
    wxBOTTOM,

    wxNORTH,
    wxSOUTH,
    wxWEST,
    wxEAST,

    wxALL,

    /*  a mask to extract direction from the combination of flags */
    wxDIRECTION_MASK
};

enum wxAlignment
{
    /*
        0 is a valid wxAlignment value (both wxALIGN_LEFT and wxALIGN_TOP
        use it) so define a symbolic name for an invalid alignment value
        which can be assumed to be different from anything else
     */
    wxALIGN_INVALID,

    wxALIGN_NOT,
    wxALIGN_CENTER_HORIZONTAL,
    wxALIGN_CENTRE_HORIZONTAL,
    wxALIGN_LEFT,
    wxALIGN_TOP,
    wxALIGN_RIGHT,
    wxALIGN_BOTTOM,
    wxALIGN_CENTER_VERTICAL,
    wxALIGN_CENTRE_VERTICAL,

    wxALIGN_CENTER,
    wxALIGN_CENTRE,

    /*  a mask to extract alignment from the combination of flags */
    wxALIGN_MASK
};

/* misc. flags for wxSizer items */
enum wxSizerFlagBits
{
    wxFIXED_MINSIZE,
    wxRESERVE_SPACE_EVEN_IF_HIDDEN,

    /*  a mask to extract wxSizerFlagBits from combination of flags */
    wxSIZER_FLAG_BITS_MASK
};

enum wxStretch
{
    wxSTRETCH_NOT,
    wxSHRINK,
    wxGROW,
    wxEXPAND,
    wxSHAPED,
    wxTILE,

    /*  a mask to extract stretch from the combination of flags */
    wxSTRETCH_MASK // sans wxTILE
};

enum wxBorder
{
    /*  this is different from wxBORDER_NONE as by default the controls do have */
    /*  border */
    wxBORDER_DEFAULT,

    wxBORDER_NONE,
    wxBORDER_STATIC,
    wxBORDER_SIMPLE,
    wxBORDER_RAISED,
    wxBORDER_SUNKEN,
    //wxBORDER_DOUBLE = 0x10000000, /* deprecated */
    wxBORDER_THEME,

    /*  a mask to extract border style from the combination of flags */
    wxBORDER_MASK
};

/* This makes it easier to specify a 'normal' border for a control */
#define wxDEFAULT_CONTROL_BORDER

/*
 * Background styles. See wxWindow::SetBackgroundStyle
 */
enum wxBackgroundStyle
{
    /*
        background is erased in the EVT_ERASE_BACKGROUND handler or using
        the system default background if no such handler is defined (this
        is the default style)
     */
    wxBG_STYLE_ERASE,

    /*
        background is erased by the system, no EVT_ERASE_BACKGROUND event
        is generated at all
     */
    wxBG_STYLE_SYSTEM,

    /*
        background is erased in EVT_PAINT handler and not erased at all
        before it, this should be used if the paint handler paints over
        the entire window to avoid flicker
     */
    wxBG_STYLE_PAINT,

    /*
        Indicates that the window background is not erased, letting the parent
        window show through.
     */
    wxBG_STYLE_TRANSPARENT,

    /* this style is deprecated and doesn't do anything, don't use */
    wxBG_STYLE_COLOUR,

    /*
        this style is deprecated and is synonymous with
        wxBG_STYLE_PAINT, use the new name
     */
    wxBG_STYLE_CUSTOM
};

/*
 * Key types used by (old style) lists and hashes.
 */
enum wxKeyType
{
    wxKEY_NONE,
    wxKEY_INTEGER,
    wxKEY_STRING
};

/* This enum contains bit mask constants used in wxKeyEvent */
enum wxKeyModifier
{
    wxMOD_NONE,
    wxMOD_ALT,
    wxMOD_CONTROL,
    wxMOD_ALTGR,
    wxMOD_SHIFT,
    wxMOD_META,
    wxMOD_WIN,
    wxMOD_RAW_CONTROL,
    wxMOD_CMD,
    wxMOD_ALL
};

/*  hit test results */
enum wxHitTest
{
    wxHT_NOWHERE,

    /*  scrollbar */
    wxHT_SCROLLBAR_FIRST,
    wxHT_SCROLLBAR_ARROW_LINE_1,    /*  left or upper arrow to scroll by line */
    wxHT_SCROLLBAR_ARROW_LINE_2,    /*  right or down */
    wxHT_SCROLLBAR_ARROW_PAGE_1,    /*  left or upper arrow to scroll by page */
    wxHT_SCROLLBAR_ARROW_PAGE_2,    /*  right or down */
    wxHT_SCROLLBAR_THUMB,           /*  on the thumb */
    wxHT_SCROLLBAR_BAR_1,           /*  bar to the left/above the thumb */
    wxHT_SCROLLBAR_BAR_2,           /*  bar to the right/below the thumb */
    wxHT_SCROLLBAR_LAST,

    /*  window */
    wxHT_WINDOW_OUTSIDE,            /*  not in this window at all */
    wxHT_WINDOW_INSIDE,             /*  in the client area */
    wxHT_WINDOW_VERT_SCROLLBAR,     /*  on the vertical scrollbar */
    wxHT_WINDOW_HORZ_SCROLLBAR,     /*  on the horizontal scrollbar */
    wxHT_WINDOW_CORNER,             /*  on the corner between 2 scrollbars */

    wxHT_MAX
};

// ---------------------------------------------------------------------------
// wxBusyCursor

#if wxLUA_USE_wxBusyCursor

#include "wx/utils.h"

class %delete wxBusyCursor
{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxBusyCursor(wxCursor* cursor = wxHOURGLASS_CURSOR);
};

// ---------------------------------------------------------------------------
// wxBusyCursorSuspender - we don't wrap this since Lua's garbage collector doesn't
// automatically collect items when they go out of scope so you would have to
// delete() this anyway which is just as easy as wxBegin/EndBusyCursor

//class %delete wxBusyCursorSuspender
//{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
//    wxBusyCursorSuspender();
//};

#endif //wxLUA_USE_wxBusyCursor

// ---------------------------------------------------------------------------
// wxBusyInfo

#if wxLUA_USE_wxBusyInfo && wxUSE_BUSYINFO

#include "wx/busyinfo.h"

class %delete wxBusyInfo : public wxObject
{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxBusyInfo(const wxString& message, wxWindow *parent = NULL);
};

#endif //wxLUA_USE_wxBusyInfo && wxUSE_BUSYINFO

// ---------------------------------------------------------------------------
// wxTimer

#if wxLUA_USE_wxTimer && wxUSE_TIMER

#include "wx/timer.h"

#define wxTIMER_CONTINUOUS
#define wxTIMER_ONE_SHOT

class %delete wxTimer : public wxEvtHandler
{
    wxTimer(wxEvtHandler *owner, int id = -1);

    int      GetInterval() const;
    bool     IsOneShot() const;
    bool     IsRunning() const;
    void     Notify();
    void     SetOwner(wxEvtHandler *owner, int id = -1);
    bool     Start(int milliseconds = -1, bool oneShot = false);
    void     Stop();
};

// ---------------------------------------------------------------------------
// wxTimerEvent

#include "wx/timer.h"

class %delete wxTimerEvent : public wxEvent
{
    %wxEventType wxEVT_TIMER // EVT_TIMER(id, fn);

    int GetInterval() const;
};

#endif //wxLUA_USE_wxTimer && wxUSE_TIMER
