// ===========================================================================
// Purpose:     wxApp and wxFrame
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================


// ---------------------------------------------------------------------------
// wxApp

#if wxLUA_USE_wxApp

#include "wx/app.h"

wxApp* wxGetApp(); // %override wxApp* wxGetApp();

class wxAppConsole : public wxEvtHandler
{
    int MainLoop();
    void ExitMainLoop();
    int FilterEvent(wxEvent& event);
    wxEventLoopBase* GetMainLoop() const;
    // void HandleEvent(wxEvtHandler* handler, wxEventFunction func, wxEvent& event) const;
    bool UsesEventLoop() const;
    void ProcessPendingEvents();
    void DeletePendingEvents();
    bool HasPendingEvents() const;
    void SuspendProcessingOfPendingEvents();
    void ResumeProcessingOfPendingEvents();
    void ScheduleForDestruction(wxObject *object);
    bool IsScheduledForDestruction(wxObject *object) const;
    bool Yield(bool onlyIfNeeded = false);
    static void SetInstance(wxAppConsole* app);
    static wxAppConsole* GetInstance();
    static bool IsMainLoopRunning();
    // void OnAssertFailure(const wxChar *file, int line, const wxChar *func, const wxChar *cond, const wxChar *msg); // not supported
    // bool OnCmdLineError(wxCmdLineParser& parser);
    // bool OnCmdLineHelp(wxCmdLineParser& parser);
    // bool OnCmdLineParsed(wxCmdLineParser& parser);
    void OnEventLoopEnter(wxEventLoopBase* loop);
    void OnEventLoopExit(wxEventLoopBase* loop);
    int OnExit();
    void OnFatalException();
    bool OnInit();
    // void OnInitCmdLine(wxCmdLineParser& parser);
    int OnRun();
    bool OnExceptionInMainLoop();
    void OnUnhandledException();
    bool StoreCurrentException();
    void RethrowStoredException();
    wxString GetAppDisplayName() const;
    wxString GetAppName() const;
    wxString GetClassName() const;
    // wxAppTraits* GetTraits(); // no wxAppTraits support
    const wxString& GetVendorDisplayName() const;
    const wxString& GetVendorName() const;
    void SetAppDisplayName(const wxString& name);
    void SetAppName(const wxString& name);
    void SetClassName(const wxString& name);
    void SetVendorDisplayName(const wxString& name);
    void SetVendorName(const wxString& name);
    void SetCLocale();
};

class wxApp : public wxAppConsole
{
    wxApp();
    wxVideoMode GetDisplayMode() const;
    bool GetExitOnFrameDelete() const;
    wxLayoutDirection GetLayoutDirection() const;
    bool GetUseBestVisual() const;
    wxWindow* GetTopWindow() const;
    bool IsActive() const;
    bool SafeYield(wxWindow *win, bool onlyIfNeeded);
    bool SafeYieldFor(wxWindow *win, long eventsToProcess);
    // %win bool ProcessMessage(WXMSG* msg);
    bool SetDisplayMode(const wxVideoMode& info);
    void SetExitOnFrameDelete(bool flag);
    bool SetNativeTheme(const wxString& theme);
    void SetTopWindow(wxWindow* window);
    
    void SetUseBestVisual(bool flag, bool forceTrueColour = false);
    %mac void MacNewFile();
    %mac void MacOpenFiles(const wxArrayString& fileNames);
    %mac void MacOpenFile(const wxString& fileName);
    %mac void MacOpenURL(const wxString& url);
    %mac void MacPrintFile(const wxString& fileName);
    %mac void MacReopenApp();
    %mac bool OSXIsGUIApplication();
    
};

#endif //wxLUA_USE_wxApp

// ---------------------------------------------------------------------------
// wxTopLevelWindow

#if wxLUA_USE_wxFrame|wxLUA_USE_wxDialog

#include "wx/toplevel.h"

enum
{
    wxUSER_ATTENTION_INFO,
    wxUSER_ATTENTION_ERROR
};

enum
{
    wxFULLSCREEN_NOMENUBAR,
    wxFULLSCREEN_NOTOOLBAR,
    wxFULLSCREEN_NOSTATUSBAR,
    wxFULLSCREEN_NOBORDER,
    wxFULLSCREEN_NOCAPTION,
    wxFULLSCREEN_ALL
};

class wxNonOwnedWindow : public wxWindow
{
    bool SetShape(const wxRegion& region);
    // bool SetShape(const wxGraphicsPath& path); // skip for too many dependencies on wxGraphicsPath
};

class wxTopLevelWindow : public wxNonOwnedWindow
{
    wxTopLevelWindow();
    wxTopLevelWindow(wxWindow *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = wxFrameNameStr);
    bool Create(wxWindow *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = wxFrameNameStr);
    bool CanSetTransparent();
    void CenterOnScreen(int direction = wxBOTH);
    void CentreOnScreen(int direction = wxBOTH);
    bool EnableCloseButton(bool enable = true);
    bool EnableMaximizeButton(bool enable = true);
    bool EnableMinimizeButton(bool enable = true);
    wxWindow* GetDefaultItem() const;
    static wxSize GetDefaultSize();
    wxIcon GetIcon() const;
    const wxIconBundle& GetIcons() const;
    wxString GetTitle() const;
    void Iconize(bool iconize);
    bool IsActive() const;
    bool IsAlwaysMaximized() const;
    bool IsFullScreen() const;
    bool IsIconized() const;
    bool IsMaximized() const;
    // bool IsUsingNativeDecorations() const; // skip wxUniv method
    bool Layout();
    void Maximize(bool maximize);
    %win wxMenu *MSWGetSystemMenu() const;
    void RequestUserAttention(int flags = wxUSER_ATTENTION_INFO);
    void Restore();
    wxWindow* SetDefaultItem(wxWindow *win);
    wxWindow* SetTmpDefaultItem(wxWindow *win);
    wxWindow* GetTmpDefaultItem() const;
    void SetIcon(const wxIcon& icon);
    void SetIcons(const wxIconBundle& icons);
    void SetMaxSize(const wxSize& size);
    void SetMinSize(const wxSize& size);
    void SetSizeHints(int minW, int minH, int maxW=-1, int maxH=-1, int incW=-1, int incH=-1);
    void SetSizeHints(const wxSize& minSize, const wxSize& maxSize=wxDefaultSize, const wxSize& incSize=wxDefaultSize);
    virtual void SetTitle(const wxString& title);
    bool SetTransparent(wxByte alpha);
    // virtual bool ShouldPreventAppExit() const; // must be overridden
    %mac void OSXSetModified(bool modified);
    %mac bool OSXIsModified() const;
    void SetRepresentedFilename(const wxString& filename);
    void ShowWithoutActivating();
    bool EnableFullScreenView(bool enable = true);
    bool ShowFullScreen(bool show, long style = wxFULLSCREEN_ALL);
    // void UseNativeDecorations(bool native = true); // skip wxUniv method
    // static void UseNativeDecorationsByDefault(bool native = true); // skip wxUniv method

};

#endif //wxLUA_USE_wxFrame|wxLUA_USE_wxDialog

// ---------------------------------------------------------------------------
// wxFrame

#if wxLUA_USE_wxFrame

#include "wx/frame.h"

#define wxDEFAULT_FRAME_STYLE
#define wxICONIZE
#define wxCAPTION
#define wxMINIMIZE
#define wxMINIMIZE_BOX
#define wxMAXIMIZE
#define wxMAXIMIZE_BOX
#define wxCLOSE_BOX
#define wxSTAY_ON_TOP
#define wxSYSTEM_MENU
//#define wxSIMPLE_BORDER see wxWindow defines
#define wxRESIZE_BORDER

#define wxFRAME_TOOL_WINDOW
#define wxFRAME_NO_TASKBAR
#define wxFRAME_FLOAT_ON_PARENT
#define wxFRAME_EX_CONTEXTHELP
#define wxFRAME_SHAPED
#define wxFRAME_EX_METAL

class wxFrame : public wxTopLevelWindow
{
    wxFrame();
    wxFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxFrame");
    void Centre(int direction = wxBOTH);
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxFrame");
    virtual wxStatusBar* CreateStatusBar(int number = 1, long style = 0, wxWindowID id = wxID_ANY, const wxString& name = "wxStatusBar");
    wxToolBar* CreateToolBar(long style = wxTB_DEFAULT_STYLE, wxWindowID id = wxID_ANY, const wxString& name = wxToolBarNameStr);
    void DoGiveHelp(const wxString& text, bool show);
    wxPoint GetClientAreaOrigin() const;
    wxMenuBar* GetMenuBar() const;
    wxStatusBar* GetStatusBar() const;
    int GetStatusBarPane();
    wxToolBar* GetToolBar() const;
    wxStatusBar* OnCreateStatusBar(int number, long style, wxWindowID id, const wxString& name);
    wxToolBar* OnCreateToolBar(long style, wxWindowID id, const wxString& name);
    void ProcessCommand(int id);
    void SetMenuBar(wxMenuBar* menuBar);
    void SetStatusBar(wxStatusBar* statusBar);
    void SetStatusBarPane(int n);
    virtual void SetStatusText(const wxString& text, int number = 0);
    void SetToolBar(wxToolBar* toolBar);
    // wxTaskBarButton* MSWGetTaskBarButton(); // skip for too many dependencies on wxTaskBarButton
    void PushStatusText(const wxString &text, int number = 0);
    void PopStatusText(int number = 0);

    virtual void SetStatusWidths(IntArray_FromLuaTable intTable); // %override parameters
};

// ---------------------------------------------------------------------------
// wxMiniFrame

#if wxLUA_USE_wxMiniFrame

#include "wx/minifram.h"

class wxMiniFrame : public wxFrame
{
    wxMiniFrame();
    wxMiniFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMiniFrame");
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMiniFrame");
};

#endif //wxLUA_USE_wxMiniFrame
#endif //wxLUA_USE_wxFrame

// ---------------------------------------------------------------------------
// wxStatusBar

#if wxLUA_USE_wxStatusBar && wxUSE_STATUSBAR

#include "wx/statusbr.h"

#define wxST_SIZEGRIP
#define wxSB_NORMAL
#define wxSB_FLAT
#define wxSB_RAISED

class wxStatusBarPane
{
    wxStatusBarPane(int style = wxSB_NORMAL, int width = 0);
    int GetWidth() const;
    int GetStyle() const;
    wxString GetText() const;
};

class wxStatusBar : public wxWindow
{
    wxStatusBar();
    wxStatusBar(wxWindow* parent, wxWindowID id, long style = wxST_SIZEGRIP, const wxString& name = "wxStatusBar");
    bool Create(wxWindow *parent, wxWindowID id, long style = wxST_SIZEGRIP, const wxString& name = "wxStatusBar");
    virtual bool GetFieldRect(int i, wxRect& rect) const;
    int GetFieldsCount() const;
    const wxStatusBarPane& GetField(int n) const;
    wxSize GetBorders() const;
    virtual wxString GetStatusText(int ir = 0) const;
    int GetStatusWidth(int n) const;
    int GetStatusStyle(int n) const;
    void PopStatusText(int field = 0);
    void PushStatusText(const wxString& string, int field = 0);
    void SetMinHeight(int height);
    virtual void SetStatusText(const wxString& text, int i = 0);
    virtual void SetFieldsCount(LuaTable intTable); // %override parameters
    virtual void SetStatusStyles(IntArray_FromLuaTable intTable); // %override parameters
    virtual void SetStatusWidths(IntArray_FromLuaTable intTable); // %override parameters
};

#endif //wxLUA_USE_wxStatusBar && wxUSE_STATUSBAR
