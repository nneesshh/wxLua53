// ---------------------------------------------------------------------------
// wxTextEntry

#include "wx/textentry.h"

// ----------------------------------------------------------------------------
// wxTextEntry types
// ----------------------------------------------------------------------------

// wxTextPos is the position in the text (currently it's hardly used anywhere
// and should probably be replaced with int anyhow)
typedef long wxTextPos;

// ----------------------------------------------------------------------------
// wxTextEntryBase
// ----------------------------------------------------------------------------

class wxTextEntryBase
{
    //wxTextEntryBase() - No constructor, base class
    

    // accessing the value
    // -------------------

    // SetValue() generates a text change event, ChangeValue() doesn't
    virtual void SetValue(const wxString& value);
    virtual void ChangeValue(const wxString& value);

    // writing text inserts it at the current position replacing any current
    // selection, appending always inserts it at the end and doesn't remove any
    // existing text (but it will reset the selection if there is any)
    virtual void AppendText(const wxString& text);

    virtual wxString GetValue() const;
    virtual wxString GetRange(long from, long to) const;
    bool IsEmpty() const;


    // editing operations
    // ------------------

    virtual void Replace(long from, long to, const wxString& value);
    virtual void Clear();
    void RemoveSelection();


    // clipboard operations
    // --------------------

    virtual bool CanCopy() const;
    virtual bool CanCut() const;
    virtual bool CanPaste() const;
    

    // insertion point
    // ---------------

    // note that moving insertion point removes any current selection
    virtual void SetInsertionPointEnd();


    // selection
    // ---------

    virtual void SelectAll();
    virtual void SelectNone();
    bool HasSelection() const;
    virtual wxString GetStringSelection() const;


    // auto-completion
    // ---------------

    // these functions allow to auto-complete the text already entered into the
    // control using either the given fixed list of strings, the paths from the
    // file system or an arbitrary user-defined completer
    //
    // they all return true if completion was enabled or false on error (most
    // commonly meaning that this functionality is not available under the
    // current platform)

    bool AutoComplete(const wxArrayString& choices);

    bool AutoCompleteFileNames();

    bool AutoCompleteDirectories();

    // notice that we take ownership of the pointer and will delete it
    //
    // if the pointer is NULL auto-completion is disabled
    //bool AutoComplete(wxTextCompleter *completer);


    // input restrictions
    // ------------------

    // set the max number of characters which may be entered in a single line
    // text control
    virtual void SetMaxLength(unsigned long len);

    // convert any lower-case characters to upper-case on the fly in this entry
    virtual void ForceUpper();


    // hints
    // -----

    // hint is the (usually greyed out) text shown in the control as long as
    // it's empty and doesn't have focus, it is typically used in controls used
    // for searching to let the user know what is supposed to be entered there

    virtual bool SetHint(const wxString& hint);
    virtual wxString GetHint() const;


    // margins
    // -------

    // margins are the empty space between borders of control and the text
    // itself. When setting margin, use value -1 to indicate that specific
    // margin should not be changed.

    bool SetMargins(const wxPoint& pt);
    bool SetMargins(wxCoord left, wxCoord top = -1);
    wxPoint GetMargins() const;


    // implementation only
    // -------------------

    // generate the wxEVT_TEXT event for GetEditableWindow(),
    // like SetValue() does and return true if the event was processed
    //
    // NB: this is public for wxRichTextCtrl use only right now, do not call it
    static bool SendTextUpdatedEvent(wxWindow *win);

    // generate the wxEVT_TEXT event for this window
    bool SendTextUpdatedEvent();


    // generate the wxEVT_TEXT event for this window if the
    // events are not currently disabled
    void SendTextUpdatedEventIfAllowed();

    // this function is provided solely for the purpose of forwarding text
    // change notifications state from one control to another, e.g. it can be
    // used by a wxComboBox which derives from wxTextEntry if it delegates all
    // of its methods to another wxTextCtrl
    void ForwardEnableTextChangedEvents(bool enable);

    // change the entry value to be in upper case only, if needed (i.e. if it's
    // not already the case)
    void ConvertToUpperCase();
};

// ----------------------------------------------------------------------------
// wxTextEntry: roughly corresponds to GtkEditable
// ----------------------------------------------------------------------------

class wxTextEntry : public wxTextEntryBase
{
public:
    //wxTextEntry(); - No constructor, base class

    // implement wxTextEntryBase pure virtual methods
    virtual void WriteText(const wxString& text);
    virtual void Remove(long from, long to);

    virtual void Copy();
    virtual void Cut();
    virtual void Paste();

    virtual void Undo();
    virtual void Redo();
    virtual bool CanUndo() const;
    virtual bool CanRedo() const;

    virtual void SetInsertionPoint(long pos);
    virtual long GetInsertionPoint() const;
    virtual long GetLastPosition() const;

    virtual void SetSelection(long from, long to);
    virtual void GetSelection(long *from, long *to) const; // %override return [long from, long to]

    virtual bool IsEditable() const;
    virtual void SetEditable(bool editable);

    virtual void SetMaxLength(unsigned long len);
    virtual void ForceUpper();

//#ifdef __WXGTK3__
//    virtual bool SetHint(const wxString& hint);
//    virtual wxString GetHint() const;
//#endif

    // implementation only from now on
    //void SendMaxLenEvent();
    //bool GTKEntryOnInsertText(const char* text);
    //bool GTKIsUpperCase() const;
};

#endif