// ===========================================================================
// Purpose:     wxDialog and all dialog classes and functions
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================


/*
 * extended dialog specifiers. these values are stored in a different
 * flag and thus do not overlap with other style flags. note that these
 * values do not correspond to the return values of the dialogs (for
 * those values, look at the wxID_XXX defines).
 */

/*  wxCENTRE already defined as  0x00000001 */
#define wxYES
#define wxOK
#define wxNO
#define wxYES_NO
#define wxCANCEL
#define wxAPPLY
#define wxCLOSE

#define wxOK_DEFAULT
#define wxYES_DEFAULT
#define wxNO_DEFAULT
#define wxCANCEL_DEFAULT

#define wxICON_WARNING
#define wxICON_ERROR
#define wxICON_QUESTION
#define wxICON_INFORMATION
#define wxICON_EXCLAMATION
#define wxICON_HAND
#define wxICON_STOP
#define wxICON_ASTERISK

#define wxHELP
#define wxFORWARD
#define wxBACKWARD
#define wxRESET
#define wxMORE
#define wxSETUP
#define wxICON_NONE
#define wxICON_AUTH_NEEDED

#define wxICON_MASK

//----------------------------------------------------------------------------
// wxFileDialog data
//----------------------------------------------------------------------------

enum
{
    wxFD_OPEN,
    wxFD_SAVE,
    wxFD_OVERWRITE_PROMPT,
    wxFD_NO_FOLLOW,
    wxFD_FILE_MUST_EXIST,
    wxFD_CHANGE_DIR,
    wxFD_PREVIEW,
    wxFD_MULTIPLE
};

#define wxFD_DEFAULT_STYLE

// ---------------------------------------------------------------------------
// Dialog functions from wxWidgets functions documentation

// Cursors
void wxBeginBusyCursor(wxCursor *cursor = wxLua_wxHOURGLASS_CURSOR);
void wxEndBusyCursor();
bool wxIsBusy();

// Miscellaneous functions
void wxBell();

#define_wxstring wxDirSelectorPromptStr wxT("Select a directory" );

// Dir dialog
wxUSE_DIRDLG wxString wxDirSelector(const wxString& message = wxDirSelectorPromptStr, const wxString& default_path = "", long style = wxDD_DEFAULT_STYLE, const wxPoint& pos = wxDefaultPosition, wxWindow *parent = NULL);
                   
// wxFileDialog convenience functions
wxUSE_FILEDLG wxString wxFileSelector(const wxString& message, const wxString& default_path = "", const wxString& default_filename = "", const wxString& default_extension = "", const wxString& wildcard = "*.*", int flags = 0, wxWindow *parent = NULL, int x = -1, int y = -1 );
wxUSE_FILEDLG wxString wxLoadFileSelector(const wxString& what, const wxString& extension, const wxString& default_name = "", wxWindow *parent = NULL);
wxUSE_FILEDLG wxString wxSaveFileSelector(const wxString& what, const wxString& extension, const wxString& default_name = "", wxWindow *parent = NULL);

// Color dialog: get the colour from user and return it
wxUSE_COLOURDLG wxColour wxGetColourFromUser(wxWindow *parent = NULL, const wxColour& colInit = wxNullColour, const wxString& caption = "", wxColourData *data = NULL);

// Font dialog: get the font from user and return it, returns wxNullFont if the dialog was cancelled
wxUSE_FONTDLG wxFont wxGetFontFromUser(wxWindow *parent = NULL, const wxFont& fontInit = wxNullFont, const wxString& caption = wxEmptyString);

// Num dialog: 
#if wxUSE_NUMBERDLG
#include "wx/numdlg.h"
long wxGetNumberFromUser(const wxString& message, const wxString& prompt, const wxString& caption, long value, long min = 0, long max = 100, wxWindow *parent = NULL, const wxPoint& pos = wxDefaultPosition);
#endif

// Test dialog:
wxUSE_TEXTDLG wxString wxGetPasswordFromUser(const wxString& message, const wxString& caption = "Input text", const wxString& default_value = "", wxWindow *parent = NULL);
wxUSE_TEXTDLG wxString wxGetTextFromUser(const wxString& message, const wxString& caption = "Input text", const wxString& default_value = "", wxWindow *parent = NULL, int x = -1, int y = -1, bool centre = true);

// Choice dialog: wrapper functions which can be used to get selection(s) from the user
wxUSE_CHOICEDLG wxString wxGetSingleChoice(const wxString& message, const wxString& caption, const wxArrayString& choices, wxWindow *parent = NULL, int x = wxDefaultCoord, int y = wxDefaultCoord, bool centre = true, int width = wxCHOICE_WIDTH, int height = wxCHOICE_HEIGHT );
wxUSE_CHOICEDLG int wxGetSingleChoiceIndex(const wxString& message, const wxString& caption, const wxArrayString& choices, wxWindow *parent = NULL, int x = wxDefaultCoord, int y = wxDefaultCoord, bool centre = true, int width = wxCHOICE_WIDTH, int height = wxCHOICE_HEIGHT );

// wxMessageBox: the simplest way to use wxMessageDialog
wxUSE_MSGDLG int wxMessageBox(const wxString& message, const wxString& caption = "Message", int style = wxOK | wxCENTRE, wxWindow *parent = NULL, int x = -1, int y = -1 );

// Tip dialog:
// wxUSE_STARTUP_TIPS bool wxShowTip(wxWindow *parent, wxTipProvider *tipProvider, bool showAtStartup = true );

// ---------------------------------------------------------------------------
// wxDialog

#if wxLUA_USE_wxDialog

#include "wx/dialog.h"

// #define wxDIALOG_MODAL %wxcompat_2_6
// #define wxDIALOG_MODELESS %wxcompat_2_6
#define wxDEFAULT_DIALOG_STYLE
#define wxDIALOG_NO_PARENT
#define wxDIALOG_EX_CONTEXTHELP
// #define wxDIALOG_EX_METAL mac only
#define wxCHOICEDLG_STYLE

class wxDialog : public wxTopLevelWindow
{
    wxDialog( );
    wxDialog(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxDialog" );
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxDialog" );

    //void Centre(int direction = wxBOTH) - see wxWindow
    wxUSE_BUTTON wxSizer* CreateButtonSizer(long flags );
    %wxchkver_2_8&&wxUSE_BUTTON wxSizer *CreateSeparatedButtonSizer(long flags );
    wxUSE_BUTTON wxStdDialogButtonSizer* CreateStdDialogButtonSizer(long flags );
    wxUSE_STATTEXT wxSizer *CreateTextSizer( const wxString &message );
    // virtual bool DoOK() - pocketpc only
    void EndModal(int retCode );
    // int GetAffirmativeId() const; // - pocketpc only
    int GetReturnCode( );
    // wxString GetTitle() const; // - see wxToplevelWindow
    //void Iconize(bool iconize); // - in wxToplevelWindow
    //bool IsIconized() const; // - in wxToplevelWindow
    bool IsModal() const;
    //void SetAffirmativeId(int affirmativeId );
    // void SetIcon(const wxIcon& icon) - in wxToplevelWindow
    // void SetModal(const bool flag) - deprecated
    void SetReturnCode(int retCode );
    // void SetTitle(const wxString& title) - in wxToplevelWindow
    // bool Show(const bool show) - see wxWindow
    int ShowModal( );
};

#endif // wxLUA_USE_wxDialog


// ---------------------------------------------------------------------------
// wxColourDialog

#if wxLUA_USE_wxColourDialog && wxUSE_COLOURDLG

#include "wx/colordlg.h"

class wxColourDialog : public wxDialog
{
    wxColourDialog(wxWindow* parent, wxColourData* data = NULL );
    //bool Create(wxWindow* parent, wxColourData* data = NULL );

    wxColourData& GetColourData( );
    //int ShowModal() - in wxDialog
};

// ---------------------------------------------------------------------------
// wxColourData

#include "wx/cmndata.h"

class %delete wxColourData : public wxObject
{
    wxColourData( );
    wxColourData(const wxColourData& cData );

    bool GetChooseFull() const;
    wxColour GetColour() const;
    wxColour GetCustomColour(int i) const;
    void SetChooseFull(bool flag );
    void SetColour(wxColour &colour );
    void SetCustomColour(int i, wxColour &colour );
};

#endif // wxLUA_USE_wxColourDialog && wxUSE_COLOURDLG

// ---------------------------------------------------------------------------
// wxFileDialog

#if wxLUA_USE_wxFileDialog && wxUSE_FILEDLG

#include "wx/filedlg.h"

#define_wxstring wxFileSelectorPromptStr wxT("Select a file" );
%wxchkver_2_9_0 #define_string wxFileSelectorDefaultWildcardStr
!%wxchkver_2_9_0 #define_wxstring wxFileSelectorDefaultWildcardStr

class wxFileDialog : public wxDialog
{
    // wxFileDialog() no default constructor in MSW
    %not_overload !%wxchkver_2_8 wxFileDialog(wxWindow* parent, const wxString& message = "Choose a file", const wxString& defaultDir = "", const wxString& defaultFile = "", const wxString& wildcard = "*.*", long style = 0, const wxPoint& pos = wxDefaultPosition );
    %not_overload %wxchkver_2_8 wxFileDialog(wxWindow *parent, const wxString& message = wxFileSelectorPromptStr, const wxString& defaultDir = "", const wxString& defaultFile = "", const wxString& wildCard = wxFileSelectorDefaultWildcardStr, long style = wxFD_DEFAULT_STYLE, const wxPoint& pos = wxDefaultPosition, const wxSize& sz = wxDefaultSize, const wxString& name = "wxFileDialog" );
    //%wxchkver_2_8 bool Create(wxWindow *parent, const wxString& message = wxFileSelectorPromptStr, const wxString& defaultDir = "", const wxString& defaultFile = "", const wxString& wildCard = wxFileSelectorDefaultWildcardStr, long style = wxFD_DEFAULT_STYLE, const wxPoint& pos = wxDefaultPosition, const wxSize& sz = wxDefaultSize, const wxString& name = "wxFileDialog" );

    wxString GetDirectory() const;
    wxString GetFilename() const;

    // %override [Lua string table] wxFileDialog::GetFilenames( );
    // C++ Func: void GetFilenames(wxArrayString& filenames) const;
    void GetFilenames() const;

    int GetFilterIndex() const;
    wxString GetMessage() const;
    wxString GetPath() const;

    // %override [Lua string table] wxFileDialog::GetPaths( );
    // C++ Func: void GetPaths(wxArrayString& paths) const;
    void GetPaths() const;

    !%wxchkver_2_8 long GetStyle() const;
    wxString GetWildcard() const;
    void SetDirectory(const wxString& directory );
    void SetFilename(const wxString& setfilename );
    void SetFilterIndex(int filterIndex );
    void SetMessage(const wxString& message );
    void SetPath(const wxString& path );
    !%wxchkver_2_8 void SetStyle(long style );
    void SetWildcard(const wxString& wildCard );
    // int ShowModal() - in wxDialog
};

#endif //wxLUA_USE_wxFileDialog && wxUSE_FILEDLG

// ---------------------------------------------------------------------------
// wxDirDialog

#if wxLUA_USE_wxDirDialog && wxUSE_DIRDLG

#include "wx/dirdlg.h"

#define wxDD_DEFAULT_STYLE
!%wxchkver_2_8 #define wxDD_NEW_DIR_BUTTON
%wxchkver_2_8 #define wxDD_CHANGE_DIR
%wxchkver_2_8 #define wxDD_DIR_MUST_EXIST

class wxDirDialog : public wxDialog
{
    wxDirDialog(wxWindow* parent, const wxString& message = "Choose a directory", const wxString& defaultPath = "", long style = 0, const wxPoint& pos = wxDefaultPosition );

    wxString GetPath() const;
    wxString GetMessage() const;
    !%wxchkver_2_8 long GetStyle() const;
    void SetMessage(const wxString& message );
    void SetPath(const wxString& path );
    !%wxchkver_2_8 void SetStyle(long style );
    // int ShowModal() - in wxDialog
};

#endif //wxLUA_USE_wxDirDialog && wxUSE_DIRDLG

// ---------------------------------------------------------------------------
// wxMessageDialog

#if wxLUA_USE_wxMessageDialog && wxUSE_MSGDLG

class wxMessageDialog : public wxDialog
{
    wxMessageDialog(wxWindow* parent, const wxString& message, const wxString& caption = "Message box", long style = wxOK | wxCANCEL | wxCENTRE, const wxPoint& pos = wxDefaultPosition );

    // int ShowModal() - in wxDialog
    
    %wxchkver_2_9_0 void SetExtendedMessage(const wxString& extendedMessage);
    %wxchkver_2_9_3 bool SetHelpLabel(const wxString& help);
    %wxchkver_2_9_3 bool SetHelpLabel(int help);
    %wxchkver_2_9_0 void SetMessage(const wxString& message);
    %wxchkver_2_9_0 bool SetOKCancelLabels(const wxString& ok, const wxString& cancel);
    %wxchkver_2_9_0 bool SetOKCancelLabels(int ok, int cancel);
    %wxchkver_2_9_0 bool SetOKLabel(const wxString& ok);
    %wxchkver_2_9_0 bool SetOKLabel(int ok);
    %wxchkver_2_9_0 bool SetYesNoCancelLabels(const wxString& yes, const wxString& no, const wxString& cancel);
    %wxchkver_2_9_0 bool SetYesNoCancelLabels(int yes, int no, int cancel);
    %wxchkver_2_9_0 bool SetYesNoLabels(const wxString& yes, const wxString& no);
    %wxchkver_2_9_0 bool SetYesNoLabels(int yes, int no);
    %wxchkver_2_9_3 wxString GetCaption() const;
    %wxchkver_2_9_0 wxString GetMessage() const;
    %wxchkver_2_9_0 wxString GetExtendedMessage() const;
    %wxchkver_2_9_0 long GetMessageDialogStyle() const;
    %wxchkver_2_9_0 bool HasCustomLabels() const;
    %wxchkver_2_9_0 wxString GetYesLabel() const;
    %wxchkver_2_9_0 wxString GetOKLabel() const;
    %wxchkver_2_9_0 wxString GetNoLabel() const;
    %wxchkver_2_9_0 wxString GetCancelLabel() const;
    %wxchkver_2_9_3 wxString GetHelpLabel() const;
    %wxchkver_2_9_3 long GetEffectiveIcon() const;
};

#endif //wxLUA_USE_wxMessageDialog && wxUSE_MSGDLG

// ---------------------------------------------------------------------------
// wxMultiChoiceDialog - use wxGetMultipleChoices

#if wxUSE_CHOICEDLG && wxLUA_USE_wxMultiChoiceDialog

class wxMultiChoiceDialog : public wxDialog
{
    wxMultiChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition );

    wxArrayInt GetSelections() const; // FIXME
    void SetSelections(const wxArrayInt& selections) const; // FIXME
    //int ShowModal() - in wxDialog
};

#endif //wxUSE_CHOICEDLG && wxLUA_USE_wxMultiChoiceDialog

// ---------------------------------------------------------------------------
// wxSingleChoiceDialog - use wxGetSingleChoice or wxGetSingleChoiceIndex

#if wxUSE_CHOICEDLG && wxLUA_USE_wxSingleChoiceDialog

class wxSingleChoiceDialog : public wxDialog
{
    // %override wxSingleChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition);
    // C++ Func: wxSingleChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, void** clientData = NULL, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition);
    wxSingleChoiceDialog(wxWindow* parent, const wxString& message, const wxString& caption, const wxArrayString& choices, long style = wxCHOICEDLG_STYLE, const wxPoint& pos = wxDefaultPosition);

    void SetSelection(int sel);
    int GetSelection() const;
    wxString GetStringSelection() const;
    void* GetSelectionData() const;

    // implementation from now on
    void OnOK(wxCommandEvent& event);
    void OnListBoxDClick(wxCommandEvent& event);
};

#endif //wxUSE_CHOICEDLG && wxLUA_USE_wxSingleChoiceDialog

// ---------------------------------------------------------------------------
// wxTextEntryDialog - see also wxGetTextFromUser

#if wxUSE_TEXTDLG && wxLUA_USE_wxTextEntryDialog

#define wxTextEntryDialogStyle

class wxTextEntryDialog : public wxDialog
{
    wxTextEntryDialog(wxWindow* parent, const wxString& message, const wxString& caption = "Please enter text", const wxString& defaultValue = "", long style = wxOK | wxCANCEL | wxCENTRE, const wxPoint& pos = wxDefaultPosition );

    wxString GetValue() const;
    void SetValue(const wxString& value );
    // int ShowModal() - in wxDialog
};

// ---------------------------------------------------------------------------
// wxPasswordEntryDialog - see also wxGetPasswordFromUser

%wxchkver_2_9_0 #define_string wxGetPasswordFromUserPromptStr
!%wxchkver_2_9_0 #define_wxstring wxGetPasswordFromUserPromptStr
#define wxTextEntryDialogStyle

class wxPasswordEntryDialog : public wxTextEntryDialog
{
    wxPasswordEntryDialog(wxWindow *parent, const wxString& message, const wxString& caption = wxGetPasswordFromUserPromptStr, const wxString& value = "", long style = wxTextEntryDialogStyle, const wxPoint& pos = wxDefaultPosition );
};

#endif //wxUSE_TEXTDLG && wxLUA_USE_wxTextEntryDialog

// ---------------------------------------------------------------------------
// wxFontDialog

#if wxUSE_FONTDLG && wxLUA_USE_wxFontDialog

#include "wx/fontdlg.h"

class wxFontDialog : public wxDialog
{
    wxFontDialog(wxWindow* parent, const wxFontData& data );

    wxFontData& GetFontData( );
    // int ShowModal() - in wxDialog
};

// ---------------------------------------------------------------------------
// wxFontData - for wxFontDialog

#include "wx/cmndata.h"

class %delete wxFontData : public wxObject
{
    wxFontData( );
    wxFontData(const wxFontData& data );

    void EnableEffects(bool enable );
    bool GetAllowSymbols( );
    wxColour GetColour( );
    wxFont GetChosenFont( );
    bool GetEnableEffects( );
    wxFont GetInitialFont( );
    bool GetShowHelp( );
    void SetAllowSymbols(bool allowSymbols );
    void SetChosenFont(const wxFont &font );
    void SetColour(const wxColour &colour );
    void SetInitialFont(const wxFont &font );
    void SetRange(int minimum, int maximum );
    void SetShowHelp(bool showHelp );
};

#endif //wxUSE_FONTDLG && wxLUA_USE_wxFontDialog

// ---------------------------------------------------------------------------
// wxFindReplaceDialog

#if wxUSE_FINDREPLDLG && wxLUA_USE_wxFindReplaceDialog

#include "wx/fdrepdlg.h"

enum wxFindReplaceDialogStyles
{
    wxFR_REPLACEDIALOG,
    wxFR_NOUPDOWN,
    wxFR_NOMATCHCASE,
    wxFR_NOWHOLEWORD
};

class wxFindReplaceDialog : public wxDialog
{
    wxFindReplaceDialog( );
    wxFindReplaceDialog(wxWindow *parent, wxFindReplaceData *findData, const wxString &title, int style = 0 );
    bool Create(wxWindow *parent, wxFindReplaceData *findData, const wxString &title, int style = 0 );

    const wxFindReplaceData *GetData( );
    void    SetData(wxFindReplaceData *findData );
};

// ---------------------------------------------------------------------------
// wxFindReplaceData - Note this must exist while used in a wxFindReplaceDialog
//                     and you should delete() it only when the dialog is closed.

enum wxFindReplaceFlags
{
    wxFR_DOWN,
    wxFR_WHOLEWORD,
    wxFR_MATCHCASE
};

class %delete wxFindReplaceData : public wxObject
{
    wxFindReplaceData(int flags = 0 );

    wxString GetFindString( );
    wxString GetReplaceString( );
    int     GetFlags( );
    void    SetFlags(int flags );
    void    SetFindString(const wxString& string );
    void    SetReplaceString(const wxString& string );
};

// ---------------------------------------------------------------------------
// wxFindDialogEvent

class %delete wxFindDialogEvent : public wxCommandEvent
{
    %wxEventType wxEVT_COMMAND_FIND                // EVT_FIND(id, fn );
    %wxEventType wxEVT_COMMAND_FIND_NEXT           // EVT_FIND_NEXT(id, fn );
    %wxEventType wxEVT_COMMAND_FIND_REPLACE        // EVT_FIND_REPLACE(id, fn );
    %wxEventType wxEVT_COMMAND_FIND_REPLACE_ALL    // EVT_FIND_REPLACE_ALL(id, fn );
    %wxEventType wxEVT_COMMAND_FIND_CLOSE          // EVT_FIND_CLOSE(id, fn );

    wxFindDialogEvent(wxEventType commandType = wxEVT_NULL, int id = 0 );

    int      GetFlags( );
    wxString GetFindString( );
    wxString GetReplaceString( );
    wxFindReplaceDialog *GetDialog( );
    void     SetFlags(int flags );
    void     SetFindString(const wxString& str );
    void     SetReplaceString(const wxString& str );
};

#endif //wxUSE_FINDREPLDLG && wxLUA_USE_wxFindReplaceDialog

// ---------------------------------------------------------------------------
// wxProgressDialog

#if wxUSE_PROGRESSDLG && wxLUA_USE_wxProgressDialog

#include "wx/progdlg.h"

#define wxPD_APP_MODAL
#define wxPD_AUTO_HIDE
#define wxPD_SMOOTH
#define wxPD_CAN_ABORT
#define wxPD_CAN_SKIP
#define wxPD_ELAPSED_TIME
#define wxPD_ESTIMATED_TIME
#define wxPD_REMAINING_TIME

class wxProgressDialog : public wxDialog
{
    wxProgressDialog(const wxString& title, const wxString& message, int maximum = 100, wxWindow* parent = NULL, int style = wxPD_AUTO_HIDE | wxPD_APP_MODAL );

    void    Resume( );

    // %override [bool, bool skip] Update(int value, const wxString& newmsg = "" );
    // C++ Func: bool Update(int value, const wxString& newmsg = "", bool* skip = NULL );
    bool    Update(int value, const wxString& newmsg = "" );
};

#endif //wxUSE_PROGRESSDLG && wxLUA_USE_wxProgressDialog

// ---------------------------------------------------------------------------
// wxTabbedDialog                deprecated; use wxNotebook instead
//
// #include "wx/wxtab.h"
// class wxTabbedDialog : public wxDialog
// {
//     wxTabbedDialog(wxWindow *parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style=wxDEFAULT_DIALOG_STYLE, const wxString& name = "wxTabbedDialog" );
//     void SetTabView(wxTabView *view );
//     wxTabView * GetTabView( );
// };

