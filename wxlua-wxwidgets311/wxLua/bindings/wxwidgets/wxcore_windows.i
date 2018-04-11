// ===========================================================================
// Purpose:     wxWindow and other container type windows
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================


wxWindow* wxFindFocusDescendant(wxWindow* ancestor);

// ---------------------------------------------------------------------------
// wxTooltip

#if wxLUA_USE_wxTooltip && wxUSE_TOOLTIPS

#include "wx/tooltip.h"

class %delete wxToolTip : public wxObject
{
    wxToolTip(const wxString &tip);

    static void Enable(bool flag);
    static void SetDelay(long milliseconds);
    void    SetTip(const wxString& tip);
    wxString GetTip();
    wxWindow *GetWindow() const;
};

#endif //wxLUA_USE_wxTooltip && wxUSE_TOOLTIPS


// ---------------------------------------------------------------------------
// wxWindowDisabler

#include "wx/utils.h"

class %delete wxWindowDisabler
{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxWindowDisabler(wxWindow *winToSkip = NULL);
};

// ---------------------------------------------------------------------------
// wxWindowUpdateLocker - Note this only calls wxWindow::Freeze() -> Thaw();

#include "wx/wupdlock.h"

class %delete wxWindowUpdateLocker
{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxWindowUpdateLocker(wxWindow *winToLock = NULL);
};

// ---------------------------------------------------------------------------
// wxWindow
#define wxSIMPLE_BORDER
#define wxDOUBLE_BORDER
#define wxSUNKEN_BORDER
#define wxRAISED_BORDER
#define wxSTATIC_BORDER
//#define wxNO_BORDER in defsutils.i
#define wxTRANSPARENT_WINDOW
// #define wxNO_3D %wxcompat_2_6
#define wxTAB_TRAVERSAL
#define wxWANTS_CHARS
#define wxVSCROLL
#define wxHSCROLL
#define wxALWAYS_SHOW_SB
#define wxCLIP_CHILDREN
#define wxNO_FULL_REPAINT_ON_RESIZE
#define wxFULL_REPAINT_ON_RESIZE

#define wxWS_EX_VALIDATE_RECURSIVELY
#define wxWS_EX_BLOCK_EVENTS
#define wxWS_EX_TRANSIENT
#define wxWS_EX_PROCESS_IDLE
#define wxWS_EX_PROCESS_UI_UPDATES

enum wxWindowVariant
{
    wxWINDOW_VARIANT_NORMAL,
    wxWINDOW_VARIANT_SMALL,
    wxWINDOW_VARIANT_MINI,
    wxWINDOW_VARIANT_LARGE,
    wxWINDOW_VARIANT_MAX
};

enum wxUpdateUI
{
    wxUPDATE_UI_NONE,
    wxUPDATE_UI_RECURSE,
    wxUPDATE_UI_FROMIDLE
};

enum wxShowEffect
{
  wxSHOW_EFFECT_NONE,
  wxSHOW_EFFECT_ROLL_TO_LEFT,
  wxSHOW_EFFECT_ROLL_TO_RIGHT,
  wxSHOW_EFFECT_ROLL_TO_TOP,
  wxSHOW_EFFECT_ROLL_TO_BOTTOM,
  wxSHOW_EFFECT_SLIDE_TO_LEFT,
  wxSHOW_EFFECT_SLIDE_TO_RIGHT,
  wxSHOW_EFFECT_SLIDE_TO_TOP,
  wxSHOW_EFFECT_SLIDE_TO_BOTTOM,
  wxSHOW_EFFECT_BLEND,
  wxSHOW_EFFECT_EXPAND,
  wxSHOW_EFFECT_MAX
};

//%mac|%x11|%motif typedef void* WXWidget
//%gtk typedef unsigned long WXWidget // GtkWidget* what could you do with it?
//%mgl typedef window_t WXWidget
//%msw|%os2 typedef unsigned long WXWidget

class %delete wxVisualAttributes
{
    wxFont font;
    wxColour colFg;
    wxColour colBg;
};


class wxWindow : public wxEvtHandler
{
    wxWindow();
    wxWindow(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxWindow");
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxWindow");
    bool AcceptsFocus() const;
    bool AcceptsFocusFromKeyboard() const;
    bool AcceptsFocusRecursively() const;
    bool IsFocusable() const;
    bool CanAcceptFocus() const;
    bool CanAcceptFocusFromKeyboard() const;
    bool HasFocus() const;
    void SetCanFocus(bool canFocus);
    virtual void SetFocus();
    void SetFocusFromKbd();
    virtual void AddChild(wxWindow* child);
    virtual void DestroyChildren();
    wxWindow* FindWindow(long id);
    wxWindow* FindWindow(const wxString& name);
    wxWindowList& GetChildren();
    virtual void RemoveChild(wxWindow* child);
    wxWindow* GetGrandParent() const;
    wxWindow* GetNextSibling() const;
    virtual wxWindow* GetParent() const;
    wxWindow* GetPrevSibling() const;
    bool IsDescendant(wxWindow* win) const; // %override wxWindow* instead of wxWindowBase* as the latter is not in public interface
    virtual bool Reparent(wxWindow* newParent);
    void AlwaysShowScrollbars(bool hflag = true, bool vflag = true);
    virtual int GetScrollPos(int orientation);
    virtual int GetScrollRange(int orientation);
    virtual int GetScrollThumb(int orientation);
    bool CanScroll(int orient) const;
    virtual bool HasScrollbar(int orient) const;
    bool IsScrollbarAlwaysShown(int orient) const;
    virtual bool ScrollLines(int lines);
    virtual bool ScrollPages(int pages);
    virtual void ScrollWindow(int dx, int dy, const wxRect* rect = NULL);
    bool LineUp();
    bool LineDown();
    bool PageUp();
    bool PageDown();
    virtual void SetScrollPos(int orientation, int pos, bool refresh = true);
    virtual void SetScrollbar(int orientation, int position, int thumbSize, int range, bool refresh = true);
    bool BeginRepositioningChildren();
    void EndRepositioningChildren();
    void CacheBestSize(const wxSize& size) const;
    wxSize ClientToWindowSize(const wxSize& size) const;
    wxSize WindowToClientSize(const wxSize& size) const;
    virtual void Fit();
    virtual void FitInside();
    wxSize FromDIP(const wxSize& sz) const;
    wxPoint FromDIP(const wxPoint& pt) const;
    int FromDIP(int d) const;
    static wxSize FromDIP(const wxSize& sz, const wxWindow* w);
    static wxPoint FromDIP(const wxPoint& pt, const wxWindow* w);
    wxSize ToDIP(const wxSize& sz) const;
    wxPoint ToDIP(const wxPoint& pt) const;
    int ToDIP(int d) const;
    static wxSize ToDIP(const wxSize& sz, const wxWindow* w);
    static wxPoint ToDIP(const wxPoint& pt, const wxWindow* w);
    virtual wxSize GetBestSize() const;
    int GetBestHeight(int width) const;
    int GetBestWidth(int height) const;
    wxSize GetClientSize() const;
    wxSize GetEffectiveMinSize() const;
    wxSize GetMaxClientSize() const;
    wxSize GetMaxSize() const;
    wxSize GetMinClientSize() const;
    wxSize GetMinSize() const;
    int GetMinWidth() const;
    int GetMinHeight() const;
    int GetMaxWidth() const;
    int GetMaxHeight() const;
    virtual wxSize GetSize() const;
    wxSize GetVirtualSize() const;
    virtual wxSize GetBestVirtualSize() const;
    virtual double GetContentScaleFactor() const;
    wxSize GetWindowBorderSize() const;
    bool InformFirstDirection(int direction, int size, int availableOtherDir);
    void InvalidateBestSize();
    void PostSizeEvent();
    void PostSizeEventToParent();
    void SendSizeEvent(int flags = 0);
    void SendSizeEventToParent(int flags = 0);
    virtual void SetClientSize(int width, int height);
    virtual void SetClientSize(const wxSize& size);
    void SetClientSize(const wxRect& rect);
    void SetContainingSizer(wxSizer* sizer);
    void SetInitialSize(const wxSize& size = wxDefaultSize);
    void SetMaxClientSize(const wxSize& size);
    void SetMaxSize(const wxSize& size);
    void SetMinClientSize(const wxSize& size);
    void SetMinSize(const wxSize& size);
    virtual void SetSize(int x, int y, int width, int height, int sizeFlags = wxSIZE_AUTO);
    virtual void SetSize(const wxRect& rect);
    void SetSize(const wxSize& size);
    virtual void SetSize(int width, int height);
    void SetSizeHints(const wxSize& minSize, const wxSize& maxSize=wxDefaultSize, const wxSize& incSize=wxDefaultSize);
    void SetSizeHints(int minW, int minH, int maxW = -1, int maxH = -1, int incW = -1, int incH = -1);
    void SetVirtualSize(int width, int height);
    void SetVirtualSize(const wxSize& size);
    void Center(int direction = wxBOTH);
    void CenterOnParent(int direction = wxBOTH);
    void Centre(int direction = wxBOTH);
    void CentreOnParent(int direction = wxBOTH);
    wxPoint GetPosition() const;
    virtual wxRect GetRect() const;
    virtual wxPoint GetScreenPosition();
    virtual wxRect GetScreenRect() const;
    wxPoint GetClientAreaOrigin() const;
    wxRect GetClientRect() const;
    void Move(int x, int y, int flags = wxSIZE_USE_EXISTING);
    void Move(const wxPoint& pt, int flags = wxSIZE_USE_EXISTING);
    void SetPosition(const wxPoint& pt);
    virtual wxPoint ClientToScreen(const wxPoint& pt) const;
    wxPoint ConvertDialogToPixels(const wxPoint& pt);
    wxSize ConvertDialogToPixels(const wxSize& sz);
    wxPoint ConvertPixelsToDialog(const wxPoint& pt);
    wxSize ConvertPixelsToDialog(const wxSize& sz);
    virtual wxPoint ScreenToClient(const wxPoint& pt) const;
    void ClearBackground();
    virtual void Freeze();
    virtual void Thaw();
    bool IsFrozen() const;
    virtual wxColour GetBackgroundColour() const;
    virtual wxBackgroundStyle GetBackgroundStyle() const;
    virtual int GetCharHeight() const;
    virtual int GetCharWidth() const;
    virtual wxVisualAttributes GetDefaultAttributes() const;
    wxFont GetFont() const;
    virtual wxColour GetForegroundColour();
    virtual wxRegion GetUpdateRegion() const;
    wxRect GetUpdateClientRect() const;
    virtual bool HasTransparentBackground() const;
    virtual void Refresh(bool eraseBackground = true, const wxRect* rect = NULL);
    void RefreshRect(const wxRect& rect, bool eraseBackground = true);
    virtual void Update();
    virtual void SetBackgroundColour(const wxColour& colour);
    virtual void SetBackgroundStyle(wxBackgroundStyle style);
    bool IsTransparentBackgroundSupported(wxString *reason = NULL) const;
    void SetFont(const wxFont& font);
    virtual void SetForegroundColour(const wxColour& colour);
    void SetOwnBackgroundColour(const wxColour& colour);
    bool InheritsBackgroundColour() const;
    bool UseBgCol() const;
    void SetOwnFont(const wxFont& font);
    void SetOwnForegroundColour(const wxColour& colour);
    void SetPalette(const wxPalette& pal);
    virtual bool ShouldInheritColours();
    virtual void SetThemeEnabled(bool enable);
    bool GetThemeEnabled() const;
    bool CanSetTransparent();
    bool SetTransparent(wxByte alpha);
    wxEvtHandler* GetEventHandler() const;
    bool HandleAsNavigationKey(const wxKeyEvent& event);
    bool HandleWindowEvent(wxEvent& event) const;
    bool ProcessWindowEvent(wxEvent& event);
    bool ProcessWindowEventLocally(wxEvent& event);
    wxEvtHandler* PopEventHandler(bool deleteHandler = false) const;
    void PushEventHandler(wxEvtHandler* handler);
    bool RemoveEventHandler(wxEvtHandler *handler);
    void SetEventHandler(wxEvtHandler* handler);
    void SetNextHandler(wxEvtHandler* handler);
    void SetPreviousHandler(wxEvtHandler* handler);
    long GetExtraStyle() const;
    long GetWindowStyleFlag() const;
    long GetWindowStyle() const;
    bool HasExtraStyle(int exFlag) const;
    bool HasFlag(int flag) const;
    void SetExtraStyle(long exStyle);
    virtual void SetWindowStyleFlag(long style);
    void SetWindowStyle(long style);
    bool ToggleWindowStyle(int flag);
    void MoveAfterInTabOrder(wxWindow *win);
    void MoveBeforeInTabOrder(wxWindow *win);
    bool Navigate(int flags = wxNavigationKeyEvent::IsForward);
    bool NavigateIn(int flags = wxNavigationKeyEvent::IsForward);
    void Lower();
    void Raise();
    bool Hide();
    bool HideWithEffect(wxShowEffect effect, unsigned int timeout = 0);
    virtual bool IsEnabled() const;
    bool IsExposed(int x, int y) const;
    bool IsExposed(wxPoint& pt) const;
    bool IsExposed(int x, int y, int w, int h) const;
    bool IsExposed(wxRect& rect) const;
    virtual bool IsShown() const;
    bool IsShownOnScreen() const;
    bool Disable();
    virtual void Enable(bool enable);
    virtual bool Show(bool show = true);
    bool ShowWithEffect(wxShowEffect effect, unsigned int timeout = 0);
    virtual wxString GetHelpText() const;
    virtual void SetHelpText(const wxString& helpText);
    wxString GetHelpTextAtPoint(const wxPoint& point, wxHelpEvent::Origin origin) const;
    wxToolTip* GetToolTip() const;
    wxString GetToolTipText() const;
    void SetToolTip(const wxString& tip);
    void SetToolTip(%ungc wxToolTip* tip);
    void UnsetToolTip();
    int GetPopupMenuSelectionFromUser(wxMenu& menu, const wxPoint& pos = wxDefaultPosition);
    int GetPopupMenuSelectionFromUser(wxMenu& menu, int x, int y);
    bool PopupMenu(wxMenu* menu, const wxPoint& pos = wxDefaultPosition);
    bool PopupMenu(wxMenu* menu, int x, int y);
    wxValidator* GetValidator() const;
    virtual void SetValidator(const wxValidator& validator);
    virtual bool TransferDataFromWindow();
    virtual bool TransferDataToWindow();
    virtual bool Validate();
    int GetId() const;
    virtual wxString GetLabel() const;
    wxLayoutDirection GetLayoutDirection() const;
    wxCoord AdjustForLayoutDirection(wxCoord x, wxCoord width, wxCoord widthTotal) const;
    virtual wxString GetName() const;
    wxWindowVariant GetWindowVariant() const;
    void SetId(wxWindowID winid);
    virtual void SetLabel(const wxString& label);
    void SetLayoutDirection(wxLayoutDirection dir);
    virtual void SetName(const wxString& name);
    void SetWindowVariant(wxWindowVariant variant);
    wxAcceleratorTable* GetAcceleratorTable() const;
    // wxAccessible* GetAccessible();
    virtual void SetAcceleratorTable(const wxAcceleratorTable& accel);
    // void SetAccessible(wxAccessible* accessible);
    virtual bool Close(bool force = false);
    virtual bool Destroy();
    bool IsBeingDeleted() const;
    wxDropTarget* GetDropTarget() const;
    void SetDropTarget(%ungc wxDropTarget* target);
    %win virtual void DragAcceptFiles(bool accept);
    const wxSizer* GetContainingSizer() const;
    wxSizer* GetSizer() const;
    void SetSizer(wxSizer* sizer, bool deleteOld=true);
    void SetSizerAndFit(wxSizer* sizer, bool deleteOld=true);
    wxLayoutConstraints* GetConstraints() const;
    void SetConstraints(wxLayoutConstraints* constraints);
    void Layout();
    void SetAutoLayout(bool autoLayout);
    bool GetAutoLayout() const;
    virtual void CaptureMouse();
    wxCaret* GetCaret() const;
    wxCursor GetCursor() const;
    bool HasCapture() const;
    virtual void ReleaseMouse();
    void SetCaret(wxCaret *caret) const;
    virtual void SetCursor(const wxCursor& cursor);
    void WarpPointer(int x, int y);
    wxHitTest HitTest(wxCoord x, wxCoord y) const;
    wxHitTest HitTest(const wxPoint& pt) const;
    wxBorder GetBorder(long flags) const;
    wxBorder GetBorder() const;
    void DoUpdateWindowUI(wxUpdateUIEvent& event);
    void* GetHandle() const;
    bool HasMultiplePages() const;
    void InheritAttributes();
    void InitDialog();
    bool IsDoubleBuffered() const;
    !%mac void SetDoubleBuffered(bool on); // %override doesn't exist on OSX
    virtual bool IsRetained() const;
    bool IsThisEnabled() const;
    bool IsTopLevel() const;
    void OnInternalIdle();
    bool SendIdleEvents(wxIdleEvent& event);
    wxUSE_HOTKEY bool RegisterHotKey(int hotkeyId, int modifiers, int virtualKeyCode); // %override wxUSE_HOTKEY
    wxUSE_HOTKEY bool UnregisterHotKey(int hotkeyId); // %override wxUSE_HOTKEY
    virtual void UpdateWindowUI(long flags = wxUPDATE_UI_NONE);
    static wxVisualAttributes GetClassDefaultAttributes(wxWindowVariant variant = wxWINDOW_VARIANT_NORMAL);
    static wxWindow* FindFocus();
    static wxWindow* FindWindowById(long id, const wxWindow* parent = 0);
    static wxWindow* FindWindowByLabel(const wxString& label, const wxWindow* parent = 0);
    static wxWindow* FindWindowByName(const wxString& name, const wxWindow* parent = 0);
    static wxWindow* GetCapture();
    static wxWindowID NewControlId(int count = 1);
    static void UnreserveControlId(wxWindowID id, int count = 1);
    %override_name wxLua_wxWindow_ClientToScreenXY virtual void ClientToScreen(int x, int y) const; // %override return [int x, int y]
    %override_name wxLua_wxWindow_GetPositionXY %rename GetPositionXY virtual void GetPosition() const; // %override return [int x, int y]
    %override_name wxLua_wxWindow_GetScreenPositionXY %rename GetScreenPositionXY virtual void GetScreenPosition() const; // %override return [int x, int y]
    %override_name wxLua_wxWindow_GetVirtualSizeWH %rename GetVirtualSizeWH void GetVirtualSize() const; // %override return [int width, int height]
    %override_name wxLua_wxWindow_ScreenToClientXY virtual void ScreenToClient(int x, int y) const; // %override return [int x, int y]
    %rename GetClientSizeWH virtual void GetClientSize() const; // %override return [int width, int height]
    %rename GetSizeWH virtual void GetSize() const; // %override return [int width, int height]
    virtual void GetTextExtent(const wxString& string, const wxFont* font = NULL) const; // %override return [int x, int y, int descent, int externalLeading]
};

// ---------------------------------------------------------------------------
// wxWindowList

#if wxLUA_USE_wxWindowList && !wxUSE_STL

class wxWindowList : public wxObjectList
{
    //wxWindowList() - no constructor, just get this from wxWindow::GetChildren();

    // This is returned from wxWindow::GetChildren(), use wxList methods and
    //   wxNode::GetData():DynamicCast("wxWindow") to retrieve the wxWindow

    // Use the wxList methods, see also wxNode
};

#endif //wxLUA_USE_wxWindowList && !wxUSE_STL

// ---------------------------------------------------------------------------
// wxPanel

class wxPanel : public wxWindow
{
    wxPanel();
    wxPanel(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTAB_TRAVERSAL, const wxString& name = "wxPanel");
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxTAB_TRAVERSAL, const wxString& name = "wxPanel");

    // void InitDialog() see wxWindow
    //virtual void SetFocus() - see wxWindow
    virtual void SetFocusIgnoringChildren();
};

// ---------------------------------------------------------------------------
// wxControl

#include "wx/control.h"

class wxControl : public wxWindow
{
    wxControl();
    wxControl(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxControl");
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxControl");

    void Command(wxCommandEvent& event);
    // wxString GetLabel();                      // see wxWindow
    // void     SetLabel(const wxString& label); // see wxWindow

    //static wxString GetLabelText(const wxString& label) translates arbitrary string, removes mnemonic characters ('&');
    wxString GetLabelText() const;
};


// ---------------------------------------------------------------------------
// wxBookCtrlBase

#if wxLUA_USE_wxNotebook && wxUSE_BOOKCTRL

#include "wx/bookctrl.h"

#define wxBK_DEFAULT
#define wxBK_TOP
#define wxBK_LEFT
#define wxBK_RIGHT
#define wxBK_BOTTOM
#define wxBK_ALIGN_MASK

enum
{
    wxBK_HITTEST_NOWHERE,
    wxBK_HITTEST_ONICON,
    wxBK_HITTEST_ONLABEL,
    wxBK_HITTEST_ONITEM,
    wxBK_HITTEST_ONPAGE
};

class wxBookCtrlBase : public wxControl
{
    // no constructors, base class

    void AdvanceSelection(bool forward = true);
    virtual bool AddPage(wxWindow *page, const wxString& text, bool bSelect = false, int imageId = -1);
    //void AssignImageList(wxImageList *imageList);
    virtual wxSize CalcSizeFromPage(const wxSize& sizePage) const;
    virtual bool DeleteAllPages();
    virtual bool DeletePage(size_t n);
    wxWindow *GetCurrentPage() const;
    wxImageList* GetImageList() const;
    virtual wxWindow *GetPage(size_t n);
    virtual size_t GetPageCount() const;
    virtual int GetPageImage(size_t n) const;
    virtual wxString GetPageText(size_t n) const;
    virtual int  GetSelection() const;
    virtual bool InsertPage(size_t n, wxWindow *page, const wxString& text, bool bSelect = false, int imageId = -1);
    virtual bool RemovePage(size_t n);
    virtual void SetImageList(wxImageList *imageList);
    virtual bool SetPageImage(size_t n, int imageId);
    virtual void SetPageSize(const wxSize& size);
    virtual bool SetPageText(size_t n, const wxString& strText);
    virtual int  SetSelection(size_t n);

    unsigned int GetInternalBorder() const;
    void SetInternalBorder(unsigned int border);
    void SetControlMargin(int margin);
    int GetControlMargin() const;
    bool IsVertical() const;
    void SetFitToCurrentPage(bool fit);
    bool GetFitToCurrentPage() const;

    virtual int ChangeSelection(size_t n);

    //virtual int HitTest(const wxPoint& pt, long* flags = NULL) const; // FIXME add this
    //virtual bool HasMultiplePages() const; // - FIXME do we need this?

    wxSizer* GetControlSizer() const;

};

// ---------------------------------------------------------------------------
// wxBookCtrlBaseEvent

class %delete wxBookCtrlBaseEvent : public wxNotifyEvent
{
    wxBookCtrlBaseEvent(wxEventType commandType = wxEVT_NULL, int winid = 0, int nSel = -1, int nOldSel = -1);

    int GetOldSelection() const;
    int GetSelection() const;         // note : must override wxCommandEvent func since it's not virtual
    void SetOldSelection(int page);
    void SetSelection(int page);
};

#endif //wxLUA_USE_wxNotebook && wxUSE_BOOKCTRL

// ---------------------------------------------------------------------------
// wxNotebook

#if wxLUA_USE_wxNotebook && wxUSE_NOTEBOOK

#include "wx/notebook.h"

enum
{
    wxNB_HITTEST_NOWHERE,
    wxNB_HITTEST_ONICON,
    wxNB_HITTEST_ONLABEL,
    wxNB_HITTEST_ONITEM
};

typedef wxWindow wxNotebookPage

class wxNotebook : public wxBookCtrlBase
{
    wxNotebook();
    wxNotebook(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxNotebook");
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxNotebook");

    // NOTE: All remmed out functions are located in wxBookCtrlBase

    //bool AddPage(wxNotebookPage* page, const wxString& text, bool select = false, int imageId = -1);
    //void AdvanceSelection(bool forward = true);
    //void AssignImageList(wxImageList* imageList);
    //bool DeleteAllPages();
    //bool DeletePage(int page);
    //wxWindow* GetCurrentPage() const;
    //wxImageList* GetImageList() const;
    //wxNotebookPage* GetPage(int page);
    //int GetPageCount() const;
    //int GetPageImage(int nPage) const;
    //wxString GetPageText(int nPage) const;
    int GetRowCount() const;
    //int GetSelection() const;
    wxColour GetThemeBackgroundColour() const;

    // %override [int page, int flags] wxNotebook::HitTest(const wxPoint& pt);
    // C++ Func: int HitTest(const wxPoint& pt, long *flags = NULL);
    int HitTest(const wxPoint& pt);

    //bool InsertPage(int index, wxNotebookPage* page, const wxString& text, bool select = false, int imageId = -1);
    //bool RemovePage(int page);
    //void SetImageList(wxImageList* imageList);
    void SetPadding(const wxSize& padding);
    //void SetPageSize(const wxSize& size);
    //bool SetPageImage(int page, int image);
    //bool SetPageText(int page, const wxString& text);
    //int  SetSelection(int page);
};

// ---------------------------------------------------------------------------
// wxNotebookEvent

class %delete wxNotebookEvent : public wxBookCtrlBaseEvent
{
    %wxEventType wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGED   // EVT_NOTEBOOK_PAGE_CHANGED(winid, fn);
    %wxEventType wxEVT_COMMAND_NOTEBOOK_PAGE_CHANGING  // EVT_NOTEBOOK_PAGE_CHANGING(winid, fn);

    wxNotebookEvent(wxEventType eventType = wxEVT_NULL, int id = 0, int sel = -1, int oldSel = -1);

    // functions in wxBookCtrlBaseEvent
    //int GetOldSelection() const;
    //int GetSelection() const;
    //void SetOldSelection(int page);
    //void SetSelection(int page);
};

#endif //wxLUA_USE_wxNotebook && wxUSE_NOTEBOOK

// ---------------------------------------------------------------------------
// wxListbook

#if wxLUA_USE_wxNotebook && wxLUA_USE_wxListCtrl && wxUSE_LISTBOOK

#include "wx/listbook.h"

#define wxLB_DEFAULT
#define wxLB_TOP
#define wxLB_BOTTOM
#define wxLB_LEFT
#define wxLB_RIGHT
#define wxLB_ALIGN_MASK

class wxListbook : public wxBookCtrlBase
{
    wxListbook();
    wxListbook(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxListbook");
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxListbook");

    // NOTE: See functions in wxBookCtrlBase

    wxListView* GetListView();
};

// ---------------------------------------------------------------------------
// wxListbookEvent

class %delete wxListbookEvent : public wxBookCtrlBaseEvent
{
    %wxEventType wxEVT_COMMAND_LISTBOOK_PAGE_CHANGED   // EVT_LISTBOOK_PAGE_CHANGED(winid, fn);
    %wxEventType wxEVT_COMMAND_LISTBOOK_PAGE_CHANGING  // EVT_LISTBOOK_PAGE_CHANGING(winid, fn);

    wxListbookEvent(wxEventType eventType = wxEVT_NULL, int id = 0, int sel = -1, int oldSel = -1);

    // functions in wxBookCtrlBaseEvent
    //int GetOldSelection() const;
    //int GetSelection() const;
    //void SetOldSelection(int page);
    //void SetSelection(int page);
};

#endif //wxLUA_USE_wxNotebook && wxLUA_USE_wxListCtrl && wxUSE_LISTBOOK

// ---------------------------------------------------------------------------
// wxChoicebook

#if wxLUA_USE_wxNotebook && wxLUA_USE_wxChoice && wxUSE_CHOICEBOOK

#include "wx/choicebk.h"

#define wxCHB_DEFAULT
#define wxCHB_TOP
#define wxCHB_BOTTOM
#define wxCHB_LEFT
#define wxCHB_RIGHT
#define wxCHB_ALIGN_MASK

class wxChoicebook : public wxBookCtrlBase
{
    wxChoicebook();
    wxChoicebook(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxChoicebook");
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxChoicebook");

    // NOTE: See functions in wxBookCtrlBase

    wxChoice* GetChoiceCtrl() const;
};

// ---------------------------------------------------------------------------
// wxChoicebookEvent

class %delete wxChoicebookEvent : public wxBookCtrlBaseEvent
{
    %wxEventType wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGED  // EVT_CHOICEBOOK_PAGE_CHANGED(winid, fn);
    %wxEventType wxEVT_COMMAND_CHOICEBOOK_PAGE_CHANGING // EVT_CHOICEBOOK_PAGE_CHANGING(winid, fn);

    wxChoicebookEvent(wxEventType eventType = wxEVT_NULL, int id = 0, int sel = -1, int oldSel = -1);

    // functions in wxBookCtrlBaseEvent
    //int GetOldSelection() const;
    //int GetSelection() const;
    //void SetOldSelection(int page);
    //void SetSelection(int page);
};

#endif //wxLUA_USE_wxNotebook && wxLUA_USE_wxChoice && wxUSE_CHOICEBOOK

// ---------------------------------------------------------------------------
// wxTreebook

#if wxLUA_USE_wxTreebook && wxUSE_TREEBOOK

#include "wx/treebook.h"

class wxTreebook : public wxBookCtrlBase
{
    wxTreebook();
    wxTreebook(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxBK_DEFAULT, const wxString& name = "wxTreebook");
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxBK_DEFAULT,const wxString& name = "wxTreebook");

    virtual bool InsertPage(size_t pos, wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool InsertSubPage(size_t pos, wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool AddPage(wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool AddSubPage(wxWindow *page, const wxString& text, bool bSelect = false, int imageId = wxNOT_FOUND);
    virtual bool IsNodeExpanded(size_t pos) const;

    virtual bool ExpandNode(size_t pos, bool expand = true);
    bool CollapseNode(size_t pos);
    int GetPageParent(size_t pos) const;
    wxTreeCtrl* GetTreeCtrl() const;
};

// ---------------------------------------------------------------------------
// wxTreebookEvent

class %delete wxTreebookEvent : public wxBookCtrlBaseEvent
{
    %wxEventType wxEVT_COMMAND_TREEBOOK_PAGE_CHANGED   // EVT_TREEBOOK_PAGE_CHANGED(winid, fn);
    %wxEventType wxEVT_COMMAND_TREEBOOK_PAGE_CHANGING  // EVT_TREEBOOK_PAGE_CHANGING(winid, fn);
    %wxEventType wxEVT_COMMAND_TREEBOOK_NODE_COLLAPSED // EVT_TREEBOOK_NODE_COLLAPSED(winid, fn);
    %wxEventType wxEVT_COMMAND_TREEBOOK_NODE_EXPANDED  // EVT_TREEBOOK_NODE_EXPANDED(winid, fn);

    wxTreebookEvent(const wxTreebookEvent& event);
    wxTreebookEvent(wxEventType commandType = wxEVT_NULL, int id = 0, int nSel = wxNOT_FOUND, int nOldSel = wxNOT_FOUND);
};

#endif // wxLUA_USE_wxTreebook && wxUSE_TREEBOOK

// ---------------------------------------------------------------------------
// wxToolbook

#if wxLUA_USE_wxToolbook && wxUSE_TOOLBOOK

#include "wx/toolbook.h"

class wxToolbook : public wxBookCtrlBase
{
    wxToolbook();
    wxToolbook(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxToolbook");
    bool Create(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxToolbook");

    wxToolBarBase* GetToolBar() const;
    // must be called in OnIdle or by application to realize the toolbar and select the initial page.
    void Realize();
};

// ---------------------------------------------------------------------------
// wxToolbookEvent

class %delete wxToolbookEvent : public wxBookCtrlBaseEvent
{
    %wxEventType wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGED   // EVT_TOOLBOOK_PAGE_CHANGED(winid, fn);
    %wxEventType wxEVT_COMMAND_TOOLBOOK_PAGE_CHANGING  // EVT_TOOLBOOK_PAGE_CHANGING(winid, fn);

    wxToolbookEvent(const wxToolbookEvent& event);
    wxToolbookEvent(wxEventType commandType = wxEVT_NULL, int id = 0, int nSel = wxNOT_FOUND, int nOldSel = wxNOT_FOUND);
};

#endif // wxLUA_USE_wxToolbook && wxUSE_TOOLBOOK

// ---------------------------------------------------------------------------
// wxTabCtrl

#if %msw && wxLUA_USE_wxTabCtrl && wxUSE_TAB_DIALOG // note: wxUSE_TAB_DIALOG is correct

#include "wx/tabctrl.h"

class wxTabCtrl : public wxControl
{
    #define wxTC_RIGHTJUSTIFY
    #define wxTC_FIXEDWIDTH
    #define wxTC_TOP
    #define wxTC_LEFT
    #define wxTC_RIGHT
    #define wxTC_BOTTOM
    #define wxTC_MULTILINE
    #define wxTC_OWNERDRAW

    wxTabCtrl(wxWindow *parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxTabCtrl");
    //bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxTabCtrl");

    bool DeleteAllItems();
    bool DeleteItem(int item);
    int GetCurFocus() const;
    wxImageList* GetImageList() const;
    int GetItemCount() const;
    wxObject * GetItemData(int item) const;
    int GetItemImage(int item) const;
    bool GetItemRect(int item, wxRect& rect) const;
    wxString GetItemText(int item) const;
    int GetRowCount() const;
    int GetSelection() const;
    int HitTest(const wxPoint& pt, long& flags);
    void InsertItem(int item, const wxString& text, int imageId = -1, wxObject *clientData = NULL);
    bool SetItemData(int item, wxObject * data);
    bool SetItemImage(int item, int image);
    void SetImageList(wxImageList* imageList);
    void SetItemSize(const wxSize& size);
    bool SetItemText(int item, const wxString& text);
    void SetPadding(const wxSize& padding);
    int SetSelection(int item);
};

// ---------------------------------------------------------------------------
// wxTabEvent

class %delete wxTabEvent : public wxCommandEvent
{
    %win %wxEventType wxEVT_COMMAND_TAB_SEL_CHANGED    // EVT_TAB_SEL_CHANGED(id, fn);
    %win %wxEventType wxEVT_COMMAND_TAB_SEL_CHANGING   // EVT_TAB_SEL_CHANGING(id, fn);

    wxTabEvent(wxEventType commandType = 0, int id = 0);
};

#endif // %msw && wxLUA_USE_wxTabCtrl && wxUSE_TAB_DIALOG


// ---------------------------------------------------------------------------
// wxScrolledWindow

#if wxLUA_USE_wxScrolledWindow

class wxScrolledWindow : public wxPanel
{
    wxScrolledWindow();
    wxScrolledWindow(wxWindow* parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHSCROLL | wxVSCROLL, const wxString& name = "wxScrolledWindow");
    bool Create(wxWindow* parent, wxWindowID id = -1, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxHSCROLL | wxVSCROLL, const wxString& name = "wxScrolledWindow");

    // %override [int xx, int yy] void wxScrolledWindow::CalcScrolledPosition(int x, int y) const;
    // C++ Func: void CalcScrolledPosition(int x, int y, int *xx, int *yy) const;
    void CalcScrolledPosition(int x, int y) const;

    // %override [int xx, int yy] void wxScrolledWindow::CalcUnscrolledPosition(int x, int y) const;
    // C++ Func: void CalcUnscrolledPosition(int x, int y, int *xx, int *yy) const;
    void CalcUnscrolledPosition(int x, int y) const;

    void EnableScrolling(const bool xScrolling, const bool yScrolling);

    // %override [int xUnit, int yUnit] wxScrolledWindow::GetScrollPixelsPerUnit() const;
    // C++ Func: void GetScrollPixelsPerUnit(int* xUnit, int* yUnit) const;
    void GetScrollPixelsPerUnit() const;

    // %override [int x, int y] wxScrolledWindow::GetViewStart() const;
    // C++ Func: void GetViewStart(int* x, int* y) const;
    void GetViewStart() const;

    // %override [int x, int y] wxScrolledWindow::GetVirtualSize() const;
    // C++ Func: void GetVirtualSize(int* x, int* y) const;
    //void GetVirtualSize() const; // see wxWindow::GetVirtualSize

    //bool IsRetained() const; // see wxWindow::IsRetained
    void PrepareDC(wxDC& dc);
    void Scroll(int x, int y);
    void SetScrollbars(int pixelsPerUnitX, int pixelsPerUnitY, int noUnitsX, int noUnitsY, int xPos = 0, int yPos = 0, bool noRefresh = false);
    void SetScrollRate(int xstep, int ystep);
    void SetTargetWindow(wxWindow* window);
    // void SetVirtualSize(int width, int height) -- see wxWindow

    //void DoPrepareDC(wxDC& dc);
};

#endif //wxLUA_USE_wxScrolledWindow

// ---------------------------------------------------------------------------
// wxSplitterWindow

#if wxLUA_USE_wxSplitterWindow

#include "wx/splitter.h"

#define wxSP_NOBORDER
#define wxSP_NOSASH
#define wxSP_BORDER
#define wxSP_PERMIT_UNSPLIT
#define wxSP_LIVE_UPDATE
#define wxSP_3DSASH
#define wxSP_3DBORDER
// #define wxSP_FULLSASH %wxcompat_2_6 obsolete
#define wxSP_3D
#define wxSP_NO_XP_THEME
// #define wxSP_SASH_AQUA  %wxcompat_2_6 obsolete

class wxSplitterWindow : public wxWindow
{
    wxSplitterWindow();
    wxSplitterWindow(wxWindow* parent, wxWindowID id, const wxPoint& point = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=wxSP_3D, const wxString& name = "wxSplitterWindow");
    bool Create(wxWindow *parent, wxWindowID id = wxID_ANY, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxSP_3D|wxCLIP_CHILDREN, const wxString& name = "wxSplitterWindow");

    int      GetMinimumPaneSize() const;
    double   GetSashGravity();
    int      GetSashPosition();
    int      GetSplitMode() const;
    wxWindow *GetWindow1() const;
    wxWindow *GetWindow2() const;
    void     Initialize(wxWindow* window);
    bool     IsSplit() const;
    bool     ReplaceWindow(wxWindow * winOld, wxWindow * winNew);
    void     SetSashGravity(double gravity);
    void     SetSashPosition(int position, const bool redraw = true);
    void     SetSashSize(int size);
    void     SetMinimumPaneSize(int paneSize);
    void     SetSplitMode(int mode);
    bool     SplitHorizontally(wxWindow* window1, wxWindow* window2, int sashPosition = 0);
    bool     SplitVertically(wxWindow* window1, wxWindow* window2, int sashPosition = 0);
    bool     Unsplit(wxWindow* toRemove = NULL);
    void     UpdateSize();
};

// ---------------------------------------------------------------------------
// wxSplitterEvent

class %delete wxSplitterEvent : public wxNotifyEvent
{
    %wxEventType wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGING  // EVT_SPLITTER_SASH_POS_CHANGING(id, fn);
    %wxEventType wxEVT_COMMAND_SPLITTER_SASH_POS_CHANGED   // EVT_SPLITTER_SASH_POS_CHANGED(id, fn);
    %wxEventType wxEVT_COMMAND_SPLITTER_DOUBLECLICKED      // EVT_SPLITTER_DCLICK(id, fn);
    %wxEventType wxEVT_COMMAND_SPLITTER_UNSPLIT            // EVT_SPLITTER_UNSPLIT(id, fn);

    wxSplitterEvent(wxEventType type = wxEVT_NULL, wxSplitterWindow *splitter = NULL);

    // NOTE! These functions will assert if you call them for an unspupported
    //       event type. Please refer to the wxWidgets C++ manual.
    int GetSashPosition();
    int GetX();
    int GetY();
    wxWindow* GetWindowBeingRemoved();
    void SetSashPosition(int pos);
};

#endif //wxLUA_USE_wxSplitterWindow


 // ---------------------------------------------------------------------------
// wxPopupWindow

#if wxLUA_USE_wxPopupWindow

#include "wx/popupwin.h"

class wxPopupWindow : public wxWindow
{
    wxPopupWindow(wxWindow* parent, int flags = wxBORDER_NONE);
    bool Create(wxWindow* parent, int flags = wxBORDER_NONE);
    virtual void Position(const wxPoint &ptOrigin, const wxSize &sizePopup);
};

#endif // wxLUA_USE_wxPopupWindow

// ---------------------------------------------------------------------------
// wxPopupTransientWindow

#if wxLUA_USE_wxPopupTransientWindow

#include "wx/popupwin.h"

class wxPopupTransientWindow : public wxPopupWindow
{
    wxPopupTransientWindow();
    wxPopupTransientWindow(wxWindow *parent, int flags = wxBORDER_NONE);
    virtual void Popup(wxWindow *focus = NULL);
    virtual void Dismiss();
    virtual void ProcessLeftDown(wxMouseEvent &event);
};

#endif // wxLUA_USE_wxPopupTransientWindow

// ---------------------------------------------------------------------------
// wxCollapsiblePane

#if wxLUA_USE_wxCollapsiblePane && wxUSE_COLLPANE

#include "wx/collpane.h"

#define wxCP_DEFAULT_STYLE

class wxCollapsiblePane : public wxControl
{
    wxCollapsiblePane();
    wxCollapsiblePane(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCollapsiblePane");
    bool Create(wxWindow *parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxCP_DEFAULT_STYLE, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxCollapsiblePane");

    bool IsCollapsed() const;
    bool IsExpanded() const;
    void Collapse(bool collapse = true);
    void Expand();
    wxWindow* GetPane() const;
};

// ---------------------------------------------------------------------------
// wxCollapsiblePaneEvent

class %delete wxCollapsiblePaneEvent : public wxCommandEvent
{
    %wxEventType wxEVT_COMMAND_COLLPANE_CHANGED // EVT_COLLAPSIBLEPANE_CHANGED(id, fn);

    wxCollapsiblePaneEvent();
    wxCollapsiblePaneEvent(wxObject *generator, int id, bool collapsed);

    bool GetCollapsed() const;
    void SetCollapsed(bool c);
};

#endif // wxLUA_USE_wxCollapsiblePane && wxUSE_COLLPANE

// ---------------------------------------------------------------------------
// wxStaticBox

#if wxLUA_USE_wxStaticBox && wxUSE_STATBOX

#include "wx/statbox.h"

class wxStaticBox : public wxControl
{
    wxStaticBox();
    wxStaticBox(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBox");
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBox");
};

#endif //wxLUA_USE_wxStaticBox && wxUSE_STATBOX

// ---------------------------------------------------------------------------
// wxStaticBitmap

#if wxLUA_USE_wxStaticBitmap && wxUSE_STATBMP

#include "wx/statbmp.h"

class wxStaticBitmap : public wxControl
{
    wxStaticBitmap();
    wxStaticBitmap(wxWindow* parent, wxWindowID id, const wxBitmap& label = wxNullBitmap, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBitmap");
    bool Create(wxWindow* parent, wxWindowID id, const wxBitmap& label = wxNullBitmap, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticBitmap");

    wxBitmap GetBitmap() const;
    virtual void SetBitmap(const wxBitmap& label);
};

#endif //wxLUA_USE_wxStaticBitmap && wxUSE_STATBMP

// ---------------------------------------------------------------------------
// wxStaticText

#if wxLUA_USE_wxStaticText && wxUSE_STATTEXT

#include "wx/stattext.h"

#define wxST_NO_AUTORESIZE

class wxStaticText : public wxControl
{
    wxStaticText();
    wxStaticText(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticText");
    bool Create(wxWindow* parent, wxWindowID id, const wxString& label, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticText");

    // wxString GetLabel() const; // - see wxWindow
    // void SetLabel(const wxString& label) - see wxWindow
    void Wrap(int width);
};

#endif //wxLUA_USE_wxStaticText && wxUSE_STATTEXT

// ---------------------------------------------------------------------------
// wxStaticLine

#if wxLUA_USE_wxStaticLine && wxUSE_STATLINE

#include "wx/statline.h"

#define wxLI_HORIZONTAL
#define wxLI_VERTICAL

class wxStaticLine : public wxControl
{
    wxStaticLine();
    wxStaticLine(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxLI_HORIZONTAL, const wxString& name = "wxStaticLine");
    bool Create(wxWindow* parent, wxWindowID id, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxString& name = "wxStaticLine");

    bool IsVertical() const;
    static int GetDefaultSize();
};

#endif //wxLUA_USE_wxStaticLine && wxUSE_STATLINE
