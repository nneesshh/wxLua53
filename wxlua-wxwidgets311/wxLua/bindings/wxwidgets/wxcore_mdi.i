// ===========================================================================
// Purpose:     wxMDI classes
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

#if wxLUA_USE_MDI && wxUSE_MDI && wxUSE_DOC_VIEW_ARCHITECTURE

#include "wx/cmdproc.h"

// ---------------------------------------------------------------------------
// wxMDIClientWindow

class wxMDIClientWindow : public wxWindow
{
};

// ---------------------------------------------------------------------------
// wxMDIParentFrame

class wxMDIParentFrame : public wxFrame
{
    wxMDIParentFrame( );
    wxMDIParentFrame(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL, const wxString& name = "wxMDIParentFrame" );
    bool Create(wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE | wxVSCROLL | wxHSCROLL, const wxString& name = "wxMDIParentFrame" );

    void ActivateNext( );
    void ActivatePrevious( );
    void ArrangeIcons( );
    void Cascade( );
    wxMDIChildFrame* GetActiveChild() const;
    wxMDIClientWindow* GetClientWindow() const;
    // virtual wxToolBar* GetToolBar() const; - see wxFrame
    %win wxMenu* GetWindowMenu() const;
    // virtual void SetToolBar(wxToolBar* toolbar) - see wxFrame
    %win void SetWindowMenu(%ungc wxMenu* menu );
    void Tile(wxOrientation orient = wxHORIZONTAL );
};

// ---------------------------------------------------------------------------
// wxMDIChildFrame

class wxMDIChildFrame : public wxFrame
{
    wxMDIChildFrame( );
    wxMDIChildFrame(wxMDIParentFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMDIChildFrame" );
    bool Create(wxMDIParentFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxMDIChildFrame" );

    void Activate( );
    %win void Maximize( );
    void Restore( );
};

// ---------------------------------------------------------------------------
// wxDocMDIParentFrame

#include "wx/docmdi.h"

class wxDocMDIParentFrame : public wxMDIParentFrame
{
    wxDocMDIParentFrame( );
    wxDocMDIParentFrame(wxDocManager *manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIParentFrame" );
    bool Create(wxDocManager *manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIParentFrame" );

    wxDocManager *GetDocumentManager() const;
};

// ---------------------------------------------------------------------------
// wxDocMDIChildFrame

class wxDocMDIChildFrame : public wxMDIChildFrame
{
    wxDocMDIChildFrame( );
    wxDocMDIChildFrame(wxDocument *doc, wxView *view, wxMDIParentFrame *frame, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize,long type = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIChildFrame" );
    bool Create(wxDocument *doc, wxView *view, wxMDIParentFrame *frame, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long type = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIChildFrame" );

    wxDocument *GetDocument() const;
    wxView *GetView() const;
    void SetDocument(wxDocument *doc );
    void SetView(wxView *view );
};

// ---------------------------------------------------------------------------
// wxDocChildFrame

#include "wx/docview.h"

class wxDocChildFrame : public wxFrame
{
    wxDocChildFrame(wxDocument* doc, wxView* view, wxFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocChildFrame" );

    wxDocument* GetDocument() const;
    wxView* GetView() const;
    void SetDocument(wxDocument *doc );
    void SetView(wxView *view );
};

// ---------------------------------------------------------------------------
// wxDocManager

enum
{
    wxDOC_NEW,
    wxDOC_SILENT
};

class wxDocManager : public wxEvtHandler
{
    // NB: flags are unused, don't pass wxDOC_XXX to this ctor
    wxDocManager(long flags = 0, bool initialize = true);

    bool Initialize();

    // Handlers for common user commands
    void OnFileClose(wxCommandEvent& event);
    void OnFileCloseAll(wxCommandEvent& event);
    void OnFileNew(wxCommandEvent& event);
    void OnFileOpen(wxCommandEvent& event);
    void OnFileRevert(wxCommandEvent& event);
    void OnFileSave(wxCommandEvent& event);
    void OnFileSaveAs(wxCommandEvent& event);
    void OnMRUFile(wxCommandEvent& event);
#if wxUSE_PRINTING_ARCHITECTURE
    void OnPrint(wxCommandEvent& event);
    void OnPreview(wxCommandEvent& event);
    void OnPageSetup(wxCommandEvent& event);
#endif // wxUSE_PRINTING_ARCHITECTURE
    void OnUndo(wxCommandEvent& event);
    void OnRedo(wxCommandEvent& event);

    // Handlers for UI update commands
    void OnUpdateFileOpen(wxUpdateUIEvent& event);
    void OnUpdateDisableIfNoDoc(wxUpdateUIEvent& event);
    void OnUpdateFileRevert(wxUpdateUIEvent& event);
    void OnUpdateFileNew(wxUpdateUIEvent& event);
    void OnUpdateFileSave(wxUpdateUIEvent& event);
    void OnUpdateFileSaveAs(wxUpdateUIEvent& event);
    void OnUpdateUndo(wxUpdateUIEvent& event);
    void OnUpdateRedo(wxUpdateUIEvent& event);

    // called when file format detection didn't work, can be overridden to do
    // something in this case
    void OnOpenFileFailure();

    wxDocument *CreateDocument(const wxString& path, long flags = 0);

    // wrapper around CreateDocument() with a more clear name
    wxDocument *CreateNewDocument();

    wxView *CreateView(wxDocument *doc, long flags = 0);
    void DeleteTemplate(wxDocTemplate *temp, long flags = 0);
    bool FlushDoc(wxDocument *doc);
    wxDocTemplate *MatchTemplate(const wxString& path);
    wxDocTemplate *SelectDocumentPath(wxDocTemplate **templates,
            int noTemplates, wxString& path, long flags, bool save = false);
    wxDocTemplate *SelectDocumentType(wxDocTemplate **templates,
            int noTemplates, bool sort = false);
    wxDocTemplate *SelectViewType(wxDocTemplate **templates,
            int noTemplates, bool sort = false);
    wxDocTemplate *FindTemplateForPath(const wxString& path);

    void AssociateTemplate(wxDocTemplate *temp);
    void DisassociateTemplate(wxDocTemplate *temp);

    // Find template from document class info, may return NULL.
    wxDocTemplate* FindTemplate(const wxClassInfo* documentClassInfo);

    // Find document from file name, may return NULL.
    wxDocument* FindDocumentByPath(const wxString& path) const;

    wxDocument *GetCurrentDocument() const;

    void SetMaxDocsOpen(int n);
    int GetMaxDocsOpen() const;

    // Add and remove a document from the manager's list
    void AddDocument(wxDocument *doc);
    void RemoveDocument(wxDocument *doc);

    // closes all currently open documents
    bool CloseDocuments(bool force = true);

    // closes the specified document
    bool CloseDocument(wxDocument* doc, bool force = false);

    // Clear remaining documents and templates
    bool Clear(bool force = true);

    // Views or windows should inform the document manager
    // when a view is going in or out of focus
    void ActivateView(wxView *view, bool activate = true);
    wxView *GetCurrentView() const;

    // This method tries to find an active view harder than GetCurrentView():
    // if the latter is NULL, it also checks if we don't have just a single
    // view and returns it then.
    wxView *GetAnyUsableView() const;


    //wxDocVector GetDocumentsVector() const;
    //wxDocTemplateVector GetTemplatesVector() const;

    wxList& GetDocuments();
    wxList& GetTemplates();

    // Return the default name for a new document (by default returns strings
    // in the form "unnamed <counter>" but can be overridden)
    wxString MakeNewDocumentName();

    // Make a frame title (override this to do something different)
    wxString MakeFrameTitle(wxDocument* doc);

    wxFileHistory *OnCreateFileHistory();
    wxFileHistory *GetFileHistory() const;

    // File history management
    void AddFileToHistory(const wxString& file);
    void RemoveFileFromHistory(size_t i);
    size_t GetHistoryFilesCount() const;
    wxString GetHistoryFile(size_t i) const;
    void FileHistoryUseMenu(wxMenu *menu);
    void FileHistoryRemoveMenu(wxMenu *menu);
#if wxUSE_CONFIG
    void FileHistoryLoad(const wxConfigBase& config);
    void FileHistorySave(wxConfigBase& config);
#endif // wxUSE_CONFIG

    void FileHistoryAddFilesToMenu();
    void FileHistoryAddFilesToMenu(wxMenu* menu);

    wxString GetLastDirectory() const;
    void SetLastDirectory(const wxString& dir);

    // Get the current document manager
    static wxDocManager* GetDocumentManager();

#if wxUSE_PRINTING_ARCHITECTURE
    wxPageSetupDialogData& GetPageSetupDialogData();
    const wxPageSetupDialogData& GetPageSetupDialogData() const;
#endif // wxUSE_PRINTING_ARCHITECTURE
};

// ---------------------------------------------------------------------------
// wxDocMDIChildFrame

//%include "wx/docmdi.h"

//class wxDocMDIChildFrame : public wxMDIChildFrame FIXME
//{
//  wxDocMDIChildFrame(wxDocument* doc, wxView* view, wxFrame* parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIChildFrame" );
//
//  wxDocument* GetDocument() const;
//  wxView* GetView() const;
//  void OnActivate(wxActivateEvent event );
//  void OnCloseWindow(wxCloseEvent& event );
//  void SetDocument(wxDocument *doc );
//  void SetView(wxView *view );
//}

// ---------------------------------------------------------------------------
// wxDocMDIParentFrame

//%include "wx/docmdi.h"

//class wxDocMDIParentFrame : public wxMDIParentFrame FIXME
//{
//  wxDocMDIParentFrame(wxDocManager* manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocMDIParentFrame" );
//
//  void OnCloseWindow(wxCloseEvent& event );
//}

// ---------------------------------------------------------------------------
// wxDocParentFrame

class wxDocParentFrame : public wxFrame
{
    wxDocParentFrame(wxDocManager* manager, wxFrame *parent, wxWindowID id, const wxString& title, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style = wxDEFAULT_FRAME_STYLE, const wxString& name = "wxDocParentFrame" );

    //void OnCloseWindow(wxCloseEvent& event );
};

// ---------------------------------------------------------------------------
// wxDocTemplate

#define wxTEMPLATE_VISIBLE
#define wxTEMPLATE_INVISIBLE
#define wxDEFAULT_TEMPLATE_FLAGS

class wxDocTemplate : public wxObject
{
    wxDocTemplate(wxDocManager* manager, const wxString& descr, const wxString& filter, const wxString& dir, const wxString& ext, const wxString& docTypeName, const wxString& viewTypeName, wxClassInfo* docClassInfo = NULL, wxClassInfo* viewClassInfo = NULL, long flags = wxDEFAULT_TEMPLATE_FLAGS );

    wxDocument* CreateDocument(const wxString& path, long flags = 0 );
    wxView* CreateView(wxDocument *doc, long flags = 0 );
    wxString GetDefaultExtension( );
    wxString GetDescription( );
    wxString GetDirectory( );
    wxDocManager * GetDocumentManager( );
    wxString GetDocumentName( );
    wxString GetFileFilter( );
    long GetFlags( );
    wxString GetViewName( );
    bool InitDocument(wxDocument* doc, const wxString& path, long flags = 0 );
    bool IsVisible( );
    void SetDefaultExtension(const wxString& ext );
    void SetDescription(const wxString& descr );
    void SetDirectory(const wxString& dir );
    void SetDocumentManager(wxDocManager *manager );
    void SetFileFilter(const wxString& filter );
    void SetFlags(long flags );
};

// ---------------------------------------------------------------------------
// wxDocument

class wxDocument : public wxEvtHandler
{
    wxDocument(wxDocument *parent = NULL);

    // accessors
    void SetFilename(const wxString& filename, bool notifyViews = false);
    wxString GetFilename() const;

    void SetTitle(const wxString& title);
    wxString GetTitle() const;

    void SetDocumentName(const wxString& name);
    wxString GetDocumentName() const;

    // access the flag indicating whether this document had been already saved,
    // SetDocumentSaved() is only used internally, don't call it
    bool GetDocumentSaved() const;
    void SetDocumentSaved(bool saved = true);

    // activate the first view of the document if any
    void Activate();

    // return true if the document hasn't been modified since the last time it
    // was saved (implying that it returns false if it was never saved, even if
    // the document is not modified)
    bool AlreadySaved() const;

    virtual bool Close();
    virtual bool Save();
    virtual bool SaveAs();
    virtual bool Revert();

//#if wxUSE_STD_IOSTREAM
//    virtual wxSTD ostream& SaveObject(wxSTD ostream& stream);
//    virtual wxSTD istream& LoadObject(wxSTD istream& stream);
//#else
//    virtual wxOutputStream& SaveObject(wxOutputStream& stream);
//    virtual wxInputStream& LoadObject(wxInputStream& stream);
//#endif

    // Called by wxWidgets
    virtual bool OnSaveDocument(const wxString& filename);
    virtual bool OnOpenDocument(const wxString& filename);
    virtual bool OnNewDocument();
    virtual bool OnCloseDocument();

    // Prompts for saving if about to close a modified document. Returns true
    // if ok to close the document (may have saved in the meantime, or set
    // modified to false)
    virtual bool OnSaveModified();

    // if you override, remember to call the default
    // implementation (wxDocument::OnChangeFilename)
    virtual void OnChangeFilename(bool notifyViews);

    // Called by framework if created automatically by the default document
    // manager: gives document a chance to initialise and (usually) create a
    // view
    virtual bool OnCreate(const wxString& path, long flags);

    // By default, creates a base wxCommandProcessor.
    virtual wxCommandProcessor *OnCreateCommandProcessor();
    virtual wxCommandProcessor *GetCommandProcessor() const;
    virtual void SetCommandProcessor(wxCommandProcessor *proc);

    // Called after a view is added or removed. The default implementation
    // deletes the document if this is there are no more views.
    virtual void OnChangedViewList();

    // Called from OnCloseDocument(), does nothing by default but may be
    // overridden. Return value is ignored.
    virtual bool DeleteContents();

    virtual bool Draw(wxDC&);
    virtual bool IsModified() const;
    virtual void Modify(bool mod);

    virtual bool AddView(wxView *view);
    virtual bool RemoveView(wxView *view);

    //wxViewVector GetViewsVector() const;

    wxList& GetViews();
    const wxList& GetViews() const;

    wxView *GetFirstView() const;

    virtual void UpdateAllViews(wxView *sender = NULL, wxObject *hint = NULL);
    virtual void NotifyClosing();

    // Remove all views (because we're closing the document)
    virtual bool DeleteAllViews();

    // Other stuff
    virtual wxDocManager *GetDocumentManager() const;
    virtual wxDocTemplate *GetDocumentTemplate() const;
    virtual void SetDocumentTemplate(wxDocTemplate *temp);

    // Get the document name to be shown to the user: the title if there is
    // any, otherwise the filename if the document was saved and, finally,
    // "unnamed" otherwise
    virtual wxString GetUserReadableName() const;

    // Returns a window that can be used as a parent for document-related
    // dialogs. Override if necessary.
    virtual wxWindow *GetDocumentWindow() const;

    // Returns true if this document is a child document corresponding to a
    // part of the parent document and not a disk file as usual.
    bool IsChildDocument() const;
};

// ---------------------------------------------------------------------------
// wxView

class wxView : public wxEvtHandler
{
    //wxView( );

    virtual void Activate(bool activate );
    virtual bool Close(bool deleteWindow = true );
    wxDocument* GetDocument() const;
    wxDocManager* GetDocumentManager() const;
    wxWindow * GetFrame( );
    wxString GetViewName() const;
    virtual void OnActivateView(bool activate, wxView *activeView, wxView *deactiveView );
    virtual void OnChangeFilename( );
    virtual bool OnClose(bool deleteWindow );
    //virtual void OnClosingDoocument( );
    virtual bool OnCreate(wxDocument* doc, long flags );
    virtual wxPrintout* OnCreatePrintout( );
    //virtual void OnDraw(wxDC& dc );
    virtual void OnUpdate(wxView* sender, wxObject* hint );
    void SetDocument(wxDocument* doc );
    void SetFrame(wxFrame* frame );
    void SetViewName(const wxString& name );
};

#endif //wxLUA_USE_MDI && wxUSE_MDI && wxUSE_DOC_VIEW_ARCHITECTURE

// ---------------------------------------------------------------------------
//  wxCommandProcessor

#if wxLUA_USE_wxCommandProcessor

#include "wx/cmdproc.h"

class wxCommandProcessor : public wxObject
{
    wxCommandProcessor(int maxCommands = -1 );

    virtual bool CanRedo() const;
    virtual bool CanUndo() const;
    virtual bool Redo( );
    virtual bool Undo( );
    virtual void ClearCommands( );
    wxList& GetCommands() const;
    int GetMaxCommands() const;
    wxMenu *GetEditMenu() const;
    wxString GetRedoAccelerator() const;
    wxString GetRedoMenuLabel() const;
    wxString GetUndoAccelerator() const;
    wxString GetUndoMenuLabel() const;
    virtual void Initialize( );
    virtual bool IsDirty( );
    virtual void MarkAsSaved( );
    void SetEditMenu(wxMenu *menu );
    virtual void SetMenuStrings( );
    void SetRedoAccelerator(const wxString& accel );
    void SetUndoAccelerator(const wxString& accel );
    virtual bool Submit(wxCommand *command, bool storeIt = true );
    virtual void Store(wxCommand *command );
    wxCommand *GetCurrentCommand() const;
};

// ---------------------------------------------------------------------------
//  wxCommand

class wxCommand : public wxObject
{
    //wxCommand(bool canUndo = false, const wxString& name = "" );

    virtual bool CanUndo( );
    virtual bool Do(); // pure virtual
    virtual wxString GetName( );
    virtual bool Undo(); // pure virtual
};

#endif //wxLUA_USE_wxCommandProcessor

// ---------------------------------------------------------------------------
// wxFileHistory

#if wxLUA_USE_wxFileHistory && wxUSE_DOC_VIEW_ARCHITECTURE

#include "wx/docview.h"

class %delete wxFileHistory : public wxObject
{
    wxFileHistory(int maxFiles = 9, wxWindowID idBase = wxID_FILE1 );

    void AddFileToHistory(const wxString& filename );
    void AddFilesToMenu( );
    void AddFilesToMenu(wxMenu* menu );
    wxString GetHistoryFile(int index) const;
    int GetMaxFiles() const;
    size_t GetCount() const;
    void Load(wxConfigBase& config );
    void RemoveFileFromHistory(size_t i );
    void RemoveMenu(wxMenu* menu );
    void Save(wxConfigBase& config );
    void UseMenu(wxMenu* menu );
};

#endif //wxLUA_USE_wxFileHistory && wxUSE_DOC_VIEW_ARCHITECTURE

