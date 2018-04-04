// ---------------------------------------------------------------------------
// wxTextCtrl

#if wxLUA_USE_wxTextCtrl && wxUSE_TEXTCTRL

#include "wx/textctrl.h"

// ----------------------------------------------------------------------------
// wxTextCtrl types
// ----------------------------------------------------------------------------

// wxTextCoord is the line or row number (which should have been unsigned but
// is long for backwards compatibility)
typedef long wxTextCoord;

// ----------------------------------------------------------------------------
// constants
// ----------------------------------------------------------------------------

// this is intentionally not enum to avoid warning fixes with
// typecasting from enum type to wxTextCoord
const wxTextCoord wxOutOfRangeTextCoord;
const wxTextCoord wxInvalidTextCoord;

// ----------------------------------------------------------------------------
// wxTextCtrl style flags
// ----------------------------------------------------------------------------

#define wxTE_NO_VSCROLL

#define wxTE_READONLY
#define wxTE_MULTILINE
#define wxTE_PROCESS_TAB

// alignment flags
#define wxTE_LEFT
#define wxTE_CENTER
#define wxTE_RIGHT
#define wxTE_CENTRE

// this style means to use RICHEDIT control and does something only under wxMSW
// and Win32 and is silently ignored under all other platforms
#define wxTE_RICH

#define wxTE_PROCESS_ENTER
#define wxTE_PASSWORD

// automatically detect the URLs and generate the events when mouse is
// moved/clicked over an URL
//
// this is for Win32 richedit and wxGTK2 multiline controls only so far
#define wxTE_AUTO_URL

// by default, the Windows text control doesn't show the selection when it
// doesn't have focus - use this style to force it to always show it
#define wxTE_NOHIDESEL

// use wxHSCROLL to not wrap text at all, wxTE_CHARWRAP to wrap it at any
// position and wxTE_WORDWRAP to wrap at words boundary
//
// if no wrapping style is given at all, the control wraps at word boundary
#define wxTE_DONTWRAP
#define wxTE_CHARWRAP // wrap at any position
#define wxTE_WORDWRAP // wrap only at words boundaries
#define wxTE_BESTWRAP // this is the default

// force using RichEdit version 2.0 or 3.0 instead of 1.0 (default) for
// wxTE_RICH controls - can be used together with or instead of wxTE_RICH
#define wxTE_RICH2

#define wxTE_CAPITALIZE

// ----------------------------------------------------------------------------
// wxTextCtrl file types
// ----------------------------------------------------------------------------

#define wxTEXT_TYPE_ANY

// ----------------------------------------------------------------------------
// wxTextCtrl::HitTest return values
// ----------------------------------------------------------------------------

// the point asked is ...
enum wxTextCtrlHitTestResult
{
    wxTE_HT_UNKNOWN,   // this means HitTest() is simply not implemented
    wxTE_HT_BEFORE,         // either to the left or upper
    wxTE_HT_ON_TEXT,        // directly on
    wxTE_HT_BELOW,          // below [the last line]
    wxTE_HT_BEYOND          // after [the end of line]
};
// ... the character returned

// ----------------------------------------------------------------------------
// Types for wxTextAttr
// ----------------------------------------------------------------------------

// Alignment

enum wxTextAttrAlignment
{
    wxTEXT_ALIGNMENT_DEFAULT,
    wxTEXT_ALIGNMENT_LEFT,
    wxTEXT_ALIGNMENT_CENTRE,
    wxTEXT_ALIGNMENT_CENTER,
    wxTEXT_ALIGNMENT_RIGHT,
    wxTEXT_ALIGNMENT_JUSTIFIED
};

// Flags to indicate which attributes are being applied
enum wxTextAttrFlags
{
    wxTEXT_ATTR_TEXT_COLOUR,
    wxTEXT_ATTR_BACKGROUND_COLOUR,

    wxTEXT_ATTR_FONT_FACE,
    wxTEXT_ATTR_FONT_POINT_SIZE,
    wxTEXT_ATTR_FONT_PIXEL_SIZE,
    wxTEXT_ATTR_FONT_WEIGHT,
    wxTEXT_ATTR_FONT_ITALIC,
    wxTEXT_ATTR_FONT_UNDERLINE,
    wxTEXT_ATTR_FONT_STRIKETHROUGH,
    wxTEXT_ATTR_FONT_ENCODING,
    wxTEXT_ATTR_FONT_FAMILY,
    wxTEXT_ATTR_FONT_SIZE,
    wxTEXT_ATTR_FONT,

    wxTEXT_ATTR_ALIGNMENT,
    wxTEXT_ATTR_LEFT_INDENT,
    wxTEXT_ATTR_RIGHT_INDENT,
    wxTEXT_ATTR_TABS,
    wxTEXT_ATTR_PARA_SPACING_AFTER,
    wxTEXT_ATTR_PARA_SPACING_BEFORE,
    wxTEXT_ATTR_LINE_SPACING,
    wxTEXT_ATTR_CHARACTER_STYLE_NAME,
    wxTEXT_ATTR_PARAGRAPH_STYLE_NAME,
    wxTEXT_ATTR_LIST_STYLE_NAME,

    wxTEXT_ATTR_BULLET_STYLE,
    wxTEXT_ATTR_BULLET_NUMBER,
    wxTEXT_ATTR_BULLET_TEXT,
    wxTEXT_ATTR_BULLET_NAME,

    wxTEXT_ATTR_BULLET,

    wxTEXT_ATTR_URL,
    wxTEXT_ATTR_PAGE_BREAK,
    wxTEXT_ATTR_EFFECTS,
    wxTEXT_ATTR_OUTLINE_LEVEL,

    wxTEXT_ATTR_AVOID_PAGE_BREAK_BEFORE,
    wxTEXT_ATTR_AVOID_PAGE_BREAK_AFTER,

    /*!
    * Character and paragraph combined styles
    */

    wxTEXT_ATTR_CHARACTER,

    wxTEXT_ATTR_PARAGRAPH,

    wxTEXT_ATTR_ALL // = (wxTEXT_ATTR_CHARACTER|wxTEXT_ATTR_PARAGRAPH)
};

/*!
 * Styles for wxTextAttr::SetBulletStyle
 */
enum wxTextAttrBulletStyle
{
    wxTEXT_ATTR_BULLET_STYLE_NONE,
    wxTEXT_ATTR_BULLET_STYLE_ARABIC,
    wxTEXT_ATTR_BULLET_STYLE_LETTERS_UPPER,
    wxTEXT_ATTR_BULLET_STYLE_LETTERS_LOWER,
    wxTEXT_ATTR_BULLET_STYLE_ROMAN_UPPER,
    wxTEXT_ATTR_BULLET_STYLE_ROMAN_LOWER,
    wxTEXT_ATTR_BULLET_STYLE_SYMBOL,
    wxTEXT_ATTR_BULLET_STYLE_BITMAP,
    wxTEXT_ATTR_BULLET_STYLE_PARENTHESES,
    wxTEXT_ATTR_BULLET_STYLE_PERIOD,
    wxTEXT_ATTR_BULLET_STYLE_STANDARD,
    wxTEXT_ATTR_BULLET_STYLE_RIGHT_PARENTHESIS,
    wxTEXT_ATTR_BULLET_STYLE_OUTLINE,

    wxTEXT_ATTR_BULLET_STYLE_ALIGN_LEFT,
    wxTEXT_ATTR_BULLET_STYLE_ALIGN_RIGHT,
    wxTEXT_ATTR_BULLET_STYLE_ALIGN_CENTRE,

    wxTEXT_ATTR_BULLET_STYLE_CONTINUATION
};

/*!
 * Styles for wxTextAttr::SetTextEffects
 */
enum wxTextAttrEffects
{
    wxTEXT_ATTR_EFFECT_NONE,
    wxTEXT_ATTR_EFFECT_CAPITALS,
    wxTEXT_ATTR_EFFECT_SMALL_CAPITALS,
    wxTEXT_ATTR_EFFECT_STRIKETHROUGH,
    wxTEXT_ATTR_EFFECT_DOUBLE_STRIKETHROUGH,
    wxTEXT_ATTR_EFFECT_SHADOW,
    wxTEXT_ATTR_EFFECT_EMBOSS,
    wxTEXT_ATTR_EFFECT_OUTLINE,
    wxTEXT_ATTR_EFFECT_ENGRAVE,
    wxTEXT_ATTR_EFFECT_SUPERSCRIPT,
    wxTEXT_ATTR_EFFECT_SUBSCRIPT,
    wxTEXT_ATTR_EFFECT_RTL,
    wxTEXT_ATTR_EFFECT_SUPPRESS_HYPHENATION
};

/*!
 * Line spacing values
 */
enum wxTextAttrLineSpacing
{
    wxTEXT_ATTR_LINE_SPACING_NORMAL,
    wxTEXT_ATTR_LINE_SPACING_HALF,
    wxTEXT_ATTR_LINE_SPACING_TWICE
};

// ----------------------------------------------------------------------------
// wxTextAttr: a structure containing the visual attributes of a text
// ----------------------------------------------------------------------------

class %delete wxTextAttr
{
    // ctors
    //wxTextAttr();
    //wxTextAttr(const wxTextAttr& attr) { Init(); Copy(attr); }
    wxTextAttr(const wxColour& colText, const wxColour& colBack = wxNullColour, const wxFont& font = wxNullFont, wxTextAttrAlignment alignment = wxTEXT_ALIGNMENT_DEFAULT);

    // Initialise this object.
    void Init();

    // Copy
    void Copy(const wxTextAttr& attr);

    // Assignment
    //void operator= (const wxTextAttr& attr);

    // Equality test
    //bool operator== (const wxTextAttr& attr) const;

    // Partial equality test.  If @a weakTest is @true, attributes of this object do not
    // have to be present if those attributes of @a attr are present. If @a weakTest is
    // @false, the function will fail if an attribute is present in @a attr but not
    // in this object.
    bool EqPartial(const wxTextAttr& attr, bool weakTest = true) const;

    // Get attributes from font.
    bool GetFontAttributes(const wxFont& font, int flags = wxTEXT_ATTR_FONT);

    // setters
    void SetTextColour(const wxColour& colText);
    void SetBackgroundColour(const wxColour& colBack);
    void SetAlignment(wxTextAttrAlignment alignment);
    void SetTabs(const wxArrayInt& tabs);
    void SetLeftIndent(int indent, int subIndent = 0);
    void SetRightIndent(int indent);

    void SetFontSize(int pointSize);
    void SetFontPointSize(int pointSize);
    void SetFontPixelSize(int pixelSize);
    void SetFontStyle(wxFontStyle fontStyle);
    void SetFontWeight(wxFontWeight fontWeight);
    void SetFontFaceName(const wxString& faceName);
    void SetFontUnderlined(bool underlined);
    void SetFontStrikethrough(bool strikethrough);
    void SetFontEncoding(wxFontEncoding encoding);
    void SetFontFamily(wxFontFamily family);

    // Set font
    void SetFont(const wxFont& font, int flags = wxTEXT_ATTR_FONT);

    void SetFlags(long flags);

    void SetCharacterStyleName(const wxString& name);
    void SetParagraphStyleName(const wxString& name);
    void SetListStyleName(const wxString& name);
    void SetParagraphSpacingAfter(int spacing);
    void SetParagraphSpacingBefore(int spacing);
    void SetLineSpacing(int spacing);
    void SetBulletStyle(int style);
    void SetBulletNumber(int n);
    void SetBulletText(const wxString& text);
    void SetBulletFont(const wxString& bulletFont);
    void SetBulletName(const wxString& name);
    void SetURL(const wxString& url);
    void SetPageBreak(bool pageBreak = true);
    void SetTextEffects(int effects);
    void SetTextEffectFlags(int effects);
    void SetOutlineLevel(int level);

    const wxColour& GetTextColour() const;
    const wxColour& GetBackgroundColour() const;
    wxTextAttrAlignment GetAlignment() const;
    const wxArrayInt& GetTabs() const;
    long GetLeftIndent() const;
    long GetLeftSubIndent() const;
    long GetRightIndent() const;
    long GetFlags() const;

    int GetFontSize() const;
    wxFontStyle GetFontStyle() const;
    wxFontWeight GetFontWeight() const;
    bool GetFontUnderlined() const;
    bool GetFontStrikethrough() const;
    const wxString& GetFontFaceName() const;
    wxFontEncoding GetFontEncoding() const;
    wxFontFamily GetFontFamily() const;

    wxFont GetFont() const;

    const wxString& GetCharacterStyleName() const;
    const wxString& GetParagraphStyleName() const;
    const wxString& GetListStyleName() const;
    int GetParagraphSpacingAfter() const;
    int GetParagraphSpacingBefore() const;

    int GetLineSpacing() const;
    int GetBulletStyle() const;
    int GetBulletNumber() const;
    const wxString& GetBulletText() const;
    const wxString& GetBulletFont() const;
    const wxString& GetBulletName() const;
    const wxString& GetURL() const;
    int GetTextEffects() const;
    int GetTextEffectFlags() const;
    int GetOutlineLevel() const;

    // accessors
    bool HasTextColour() const;
    bool HasBackgroundColour() const;
    bool HasAlignment() const;
    bool HasTabs() const;
    bool HasLeftIndent() const;
    bool HasRightIndent() const;
    bool HasFontWeight() const;
    bool HasFontSize() const;
    bool HasFontPointSize() const;
    bool HasFontPixelSize() const;
    bool HasFontItalic() const;
    bool HasFontUnderlined() const;
    bool HasFontStrikethrough() const;
    bool HasFontFaceName() const;
    bool HasFontEncoding() const;
    bool HasFontFamily() const;
    bool HasFont() const;

    bool HasParagraphSpacingAfter() const;
    bool HasParagraphSpacingBefore() const;
    bool HasLineSpacing() const;
    bool HasCharacterStyleName() const;
    bool HasParagraphStyleName() const;
    bool HasListStyleName() const;
    bool HasBulletStyle() const;
    bool HasBulletNumber() const;
    bool HasBulletText() const;
    bool HasBulletName() const;
    bool HasURL() const;
    bool HasPageBreak() const;
    bool HasTextEffects() const;
    bool HasTextEffect(int effect) const;
    bool HasOutlineLevel() const;

    bool HasFlag(long flag) const;
    void RemoveFlag(long flag);
    void AddFlag(long flag);

    // Is this a character style?
    bool IsCharacterStyle() const;
    bool IsParagraphStyle() const;

    // returns false if we have any attributes set, true otherwise
    bool IsDefault() const;

    // Merges the given attributes. If compareWith
    // is non-NULL, then it will be used to mask out those attributes that are the same in style
    // and compareWith, for situations where we don't want to explicitly set inherited attributes.
    bool Apply(const wxTextAttr& style, const wxTextAttr* compareWith = NULL);

    // merges the attributes of the base and the overlay objects and returns
    // the result; the parameter attributes take precedence
    //
    // WARNING: the order of arguments is the opposite of Combine()
    static wxTextAttr Merge(const wxTextAttr& base, const wxTextAttr& overlay);

    // merges the attributes of this object and overlay
    void Merge(const wxTextAttr& overlay);

    // return the attribute having the valid font and colours: it uses the
    // attributes set in attr and falls back first to attrDefault and then to
    // the text control font/colours for those attributes which are not set
    static wxTextAttr Combine(const wxTextAttr& attr, const wxTextAttr& attrDef, const wxTextCtrlBase *text);

    // Compare tabs
    static bool TabsEq(const wxArrayInt& tabs1, const wxArrayInt& tabs2);

    // Remove attributes
    static bool RemoveStyle(wxTextAttr& destStyle, const wxTextAttr& style);

    // Combine two bitlists, specifying the bits of interest with separate flags.
    static bool CombineBitlists(int& valueA, int valueB, int& flagsA, int flagsB);

    // Compare two bitlists
    static bool BitlistsEqPartial(int valueA, int valueB, int flags);

    // Split into paragraph and character styles
    static bool SplitParaCharStyles(const wxTextAttr& style, wxTextAttr& parStyle, wxTextAttr& charStyle);
};

// ----------------------------------------------------------------------------
// wxTextAreaBase: multiline text control specific methods
// ----------------------------------------------------------------------------

class wxTextAreaBase
{
    //wxTextAreaBase() - No constructor, base class

    // file IO
    // -------

    bool LoadFile(const wxString& file, int fileType = wxTEXT_TYPE_ANY);
    bool SaveFile(const wxString& file = wxEmptyString, int fileType = wxTEXT_TYPE_ANY);

    // dirty flag handling
    // -------------------

    void SetModified(bool modified);


    // styles handling
    // ---------------

    // text control under some platforms supports the text styles: these
    // methods allow to apply the given text style to the given selection or to
    // set/get the style which will be used for all appended text
    virtual const wxTextAttr& GetDefaultStyle() const;


    // translate the given position (which is just an index in the text control)
    // to client coordinates
    wxPoint PositionToCoords(long pos) const;


    // find the character at position given in pixels
    //
    // NB: pt is in device coords (not adjusted for the client area origin nor
    //     scrolling)
    virtual wxTextCtrlHitTestResult HitTest(const wxPoint& pt, long *pos) const;
    virtual wxTextCtrlHitTestResult HitTest(const wxPoint& pt, wxTextCoord *col, wxTextCoord *row) const;
};

// this class defines wxTextCtrl interface, wxTextCtrlBase actually implements
// too much things because it derives from wxTextEntry and not wxTextEntryBase
// and so any classes which "look like" wxTextCtrl (such as wxRichTextCtrl)
// but don't need the (native) implementation bits from wxTextEntry should
// actually derive from this one and not wxTextCtrlBase
class wxTextCtrlIface : public wxTextAreaBase, public wxTextEntryBase
{
    //wxTextCtrlIface();  - No constructor, base class

    // wxTextAreaBase overrides
    virtual wxString GetValue() const;
    virtual void SetValue(const wxString& value);
};

// ----------------------------------------------------------------------------
// wxTextCtrl: a single or multiple line text zone where user can edit text
// ----------------------------------------------------------------------------

class wxTextCtrlBase : public wxControl, public wxTextAreaBase, public wxTextEntry
{
    //wxTextCtrlBase() - No constructor, base class

    // more readable flag testing methods
    bool IsSingleLine() const;
    bool IsMultiLine() const;

    // stream-like insertion operators: these are always available, whether we
    // were, or not, compiled with streambuf support
    //wxTextCtrl& operator<<(const wxString& s);
    //wxTextCtrl& operator<<(int i);
    //wxTextCtrl& operator<<(long i);
    //wxTextCtrl& operator<<(float f) { return *this << double(f); }
    //wxTextCtrl& operator<<(double d);
    //wxTextCtrl& operator<<(char c) { return *this << wxString(c); }
    //wxTextCtrl& operator<<(wchar_t c) { return *this << wxString(c); }

    // insert the character which would have resulted from this key event,
    // return true if anything has been inserted
    virtual bool EmulateKeyPress(const wxKeyEvent& event);


    // do the window-specific processing after processing the update event
    virtual void DoUpdateWindowUI(wxUpdateUIEvent& event);

    virtual bool ShouldInheritColours() const;

    // work around the problem with having HitTest() both in wxControl and
    // wxTextAreaBase base classes
    virtual wxTextCtrlHitTestResult HitTest(const wxPoint& pt, long *pos) const;
    virtual wxTextCtrlHitTestResult HitTest(const wxPoint& pt, wxTextCoord *col, wxTextCoord *row) const;

    // we provide stubs for these functions as not all platforms have styles
    // support, but we really should leave them pure virtual here
    virtual bool SetStyle(long start, long end, const wxTextAttr& style);
    virtual bool GetStyle(long position, wxTextAttr& style);
    virtual bool SetDefaultStyle(const wxTextAttr& style);

    // wxTextAreaBase overrides
    virtual wxString GetValue() const;
    virtual void SetValue(const wxString& value);

    // wxWindow overrides
    virtual wxVisualAttributes GetDefaultAttributes() const;

    static wxVisualAttributes GetClassDefaultAttributes(wxWindowVariant variant = wxWINDOW_VARIANT_NORMAL);

};

// ----------------------------------------------------------------------------
// wxTextCtrl events
// ----------------------------------------------------------------------------

class %delete wxTextUrlEvent : public wxCommandEvent
{
    wxTextUrlEvent(int winid, const wxMouseEvent& evtMouse, long start, long end);

    // get the mouse event which happened over the URL
    const wxMouseEvent& GetMouseEvent() const;

    // get the start of the URL
    long GetURLStart() const;

    // get the end of the URL
    long GetURLEnd() const;

    virtual wxEvent *Clone();
};

class wxTextCtrl : public wxTextCtrlBase
{
    // creation
    // --------

    wxTextCtrl();
    wxTextCtrl(wxWindow *parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxTextCtrl");
    bool Create(wxWindow* parent, wxWindowID id, const wxString& value = "", const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = 0, const wxValidator& validator = wxDefaultValidator, const wxString& name = "wxTextCtrl");

    // overridden wxTextEntry methods
    // ------------------------------

    virtual wxString GetValue() const;
    virtual wxString GetRange(long from, long to) const;

    virtual bool IsEmpty() const;

    virtual void WriteText(const wxString& text);
    virtual void AppendText(const wxString& text);
    virtual void Clear();

    virtual int GetLineLength(long lineNo) const;
    virtual wxString GetLineText(long lineNo) const;
    virtual int GetNumberOfLines() const;

    virtual void SetMaxLength(unsigned long len);

    virtual void GetSelection(long *from, long *to) const;

    virtual void Redo();
    virtual bool CanRedo() const;

    virtual void SetInsertionPointEnd();
    virtual long GetInsertionPoint() const;
    virtual wxTextPos GetLastPosition() const;

    // implement base class pure virtuals
    // ----------------------------------

    virtual bool IsModified() const;
    virtual void MarkDirty();
    virtual void DiscardEdits();

    virtual bool EmulateKeyPress(const wxKeyEvent& event);

#if wxUSE_RICHEDIT
    // apply text attribute to the range of text (only works with richedit
    // controls)
    virtual bool SetStyle(long start, long end, const wxTextAttr& style);
    virtual bool SetDefaultStyle(const wxTextAttr& style);
    virtual bool GetStyle(long position, wxTextAttr& style);
#endif // wxUSE_RICHEDIT

    // translate between the position (which is just an index in the text ctrl
    // considering all its contents as a single strings) and (x, y) coordinates
    // which represent column and line.
    virtual long XYToPosition(long x, long y) const;
    virtual bool PositionToXY(long pos, long *x, long *y) const; // %override return [bool, int x, int y]

    virtual void ShowPosition(long pos);
    %rename HitTestPos virtual wxTextCtrlHitTestResult HitTest(const wxPoint& pt, long *pos) const; // %override return [wxTextCtrlHitTestResult, int pos]
    virtual wxTextCtrlHitTestResult HitTest(const wxPoint& pt, wxTextCoord *col, wxTextCoord *row) const; // %override return [wxTextCtrlHitTestResult, int col, int row]

    virtual void SetLayoutDirection(wxLayoutDirection dir);
    virtual wxLayoutDirection GetLayoutDirection() const;

    // Caret handling (Windows only)
    bool ShowNativeCaret(bool show = true);
    bool HideNativeCaret();

    // Implementation from now on
    // --------------------------

#if wxUSE_DRAG_AND_DROP && wxUSE_RICHEDIT
    virtual void SetDropTarget(wxDropTarget *dropTarget);
#endif // wxUSE_DRAG_AND_DROP && wxUSE_RICHEDIT

    virtual void SetWindowStyleFlag(long style);

    virtual void Command(wxCommandEvent& event);
    //virtual bool MSWCommand(WXUINT param, WXWORD id);
    //virtual WXHBRUSH MSWControlColor(WXHDC hDC, WXHWND hWnd);

#if wxUSE_RICHEDIT
    //virtual bool MSWOnNotify(int idCtrl, WXLPARAM lParam, WXLPARAM *result);

    int GetRichVersion() const;
    bool IsRich() const;

    // rich edit controls are not compatible with normal ones and we must set
    // the colours and font for them otherwise
    virtual bool SetBackgroundColour(const wxColour& colour);
    virtual bool SetForegroundColour(const wxColour& colour);
    virtual bool SetFont(const wxFont& font);
#endif // wxUSE_RICHEDIT

#if !wxUSE_RICHEDIT
    bool IsRich() const;
#endif // !wxUSE_RICHEDIT

#if wxUSE_INKEDIT && wxUSE_RICHEDIT
    bool IsInkEdit() const;
#endif // wxUSE_INKEDIT && wxUSE_RICHEDIT

#if !wxUSE_INKEDIT || !wxUSE_RICHEDIT
    bool IsInkEdit() const;
#endif // !wxUSE_INKEDIT || !wxUSE_RICHEDIT

    virtual void AdoptAttributesFromHWND();

    virtual bool AcceptsFocusFromKeyboard() const;

    // returns true if the platform should explicitly apply a theme border
    virtual bool CanApplyThemeBorder() const;

    // callbacks
    void OnDropFiles(wxDropFilesEvent& event);
    void OnChar(wxKeyEvent& event); // Process 'enter' if required

    void OnCut(wxCommandEvent& event);
    void OnCopy(wxCommandEvent& event);
    void OnPaste(wxCommandEvent& event);
    void OnUndo(wxCommandEvent& event);
    void OnRedo(wxCommandEvent& event);
    void OnDelete(wxCommandEvent& event);
    void OnSelectAll(wxCommandEvent& event);

    void OnUpdateCut(wxUpdateUIEvent& event);
    void OnUpdateCopy(wxUpdateUIEvent& event);
    void OnUpdatePaste(wxUpdateUIEvent& event);
    void OnUpdateUndo(wxUpdateUIEvent& event);
    void OnUpdateRedo(wxUpdateUIEvent& event);
    void OnUpdateDelete(wxUpdateUIEvent& event);
    void OnUpdateSelectAll(wxUpdateUIEvent& event);

    // Show a context menu for Rich Edit controls (the standard
    // EDIT control has one already)
    void OnContextMenu(wxContextMenuEvent& event);

#if wxUSE_RICHEDIT
    // Create context menu for RICHEDIT controls. This may be called once during
    // the control's lifetime or every time the menu is shown, depending on
    // implementation.
    virtual wxMenu *MSWCreateContextMenu();
#endif // wxUSE_RICHEDIT

    // be sure the caret remains invisible if the user
    // called HideNativeCaret() before
    void OnSetFocus(wxFocusEvent& event);

    // intercept WM_GETDLGCODE
    //virtual bool MSWHandleMessage(WXLRESULT *result, WXUINT message, WXWPARAM wParam, WXLPARAM lParam);

    //virtual bool MSWShouldPreProcessMessage(WXMSG* pMsg);
    //virtual WXDWORD MSWGetStyle(long style, WXDWORD *exstyle) const;
};

#endif // wxLUA_USE_wxTextCtrl && wxUSE_TEXTCTRL