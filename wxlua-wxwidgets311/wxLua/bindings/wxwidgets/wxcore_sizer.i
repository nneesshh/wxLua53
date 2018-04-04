// ===========================================================================
// Purpose:     wxSizers and wxLayoutConstraints
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

#if wxLUA_USE_wxSizer

#include "wx/sizer.h"

#define wxUSE_BORDER_BY_DEFAULT

// ----------------------------------------------------------------------------
// wxSizerFlags: flags used for an item in the sizer
// ----------------------------------------------------------------------------

class %delete wxSizerFlags
{
    // construct the flags object initialized with the given proportion (0 by default)
    wxSizerFlags(int proportion = 0);

    // setters for all sizer flags, they all return the object itself so that
    // calls to them can be chained

    wxSizerFlags& Proportion(int proportion);

    wxSizerFlags& Expand();

    // notice that Align() replaces the current alignment flags, use specific
    // methods below such as Top(), Left() &c if you want to set just the
    // vertical or horizontal alignment
    wxSizerFlags& Align(int alignment); // combination of wxAlignment values

    // some shortcuts for Align()
    wxSizerFlags& Centre();
    wxSizerFlags& Center();

    wxSizerFlags& CentreVertical();
    wxSizerFlags& CenterVertical();

    wxSizerFlags& CentreHorizontal();
    wxSizerFlags& CenterHorizontal();

    wxSizerFlags& Top();
    wxSizerFlags& Left();
    wxSizerFlags& Right();
    wxSizerFlags& Bottom();
    
    // default border size used by Border() below
    static int GetDefaultBorder();

    wxSizerFlags& Border(int direction, int borderInPixels);
    wxSizerFlags& Border(int direction = wxALL);

    wxSizerFlags& DoubleBorder(int direction = wxALL);
    wxSizerFlags& TripleBorder(int direction = wxALL);
    wxSizerFlags& HorzBorder();
    wxSizerFlags& DoubleHorzBorder();

    // setters for the others flags
    wxSizerFlags& Shaped();
    wxSizerFlags& FixedMinSize();

    // makes the item ignore window's visibility status
    wxSizerFlags& ReserveSpaceEvenIfHidden();

    // accessors for wxSizer only
    int GetProportion() const;
    int GetFlags() const;
    int GetBorderInPixels() const;
};    

// ----------------------------------------------------------------------------
// wxSizerSpacer: used by wxSizerItem to represent a spacer
// ----------------------------------------------------------------------------

class %delete wxSizerSpacer
{
    wxSizerSpacer(const wxSize& size);

    void SetSize(const wxSize& size);
    const wxSize& GetSize() const;

    void Show(bool show);
    bool IsShown() const;
};

// ----------------------------------------------------------------------------
// wxSizerItem
// ----------------------------------------------------------------------------

class wxSizerItem : public wxObject
{
public:
    // window
    wxSizerItem(wxWindow *window, int proportion=0, int flag=0, int border=0, %ungc wxObject* userData=NULL);

    // window with flags
    wxSizerItem(wxWindow *window, const wxSizerFlags& flags);

    // subsizer
    wxSizerItem(wxSizer *sizer, int proportion=0, int flag=0, int border=0, %ungc wxObject* userData=NULL);

    // sizer with flags
    wxSizerItem(wxSizer *sizer, const wxSizerFlags& flags);

    // spacer
    wxSizerItem(int width, int height, int proportion=0, int flag=0, int border=0, %ungc wxObject* userData=NULL);

    // spacer with flags
    wxSizerItem(int width, int height, const wxSizerFlags& flags);

    wxSizerItem();

    virtual void DeleteWindows();

    // Enable deleting the SizerItem without destroying the contained sizer.
    void DetachSizer();

    virtual wxSize GetSize() const;
    virtual wxSize CalcMin();
    virtual void SetDimension(const wxPoint& pos, const wxSize& size);

    wxSize GetMinSize() const;
    wxSize GetMinSizeWithBorder() const;

    wxSize GetMaxSize() const;
    wxSize GetMaxSizeWithBorder() const;

    void SetMinSize(const wxSize& size);
    void SetMinSize(int x, int y);
    void SetInitSize(int x, int y);

    // if either of dimensions is zero, ratio is assumed to be 1
    // to avoid "divide by zero" errors
    void SetRatio(int width, int height);
    void SetRatio(const wxSize& size);
    void SetRatio(float ratio);
    float GetRatio() const;

    virtual wxRect GetRect();

    // set a sizer item id (different from a window id, all sizer items,
    // including spacers, can have an associated id)
    void SetId(int id);
    int GetId() const;

    bool IsWindow() const;
    bool IsSizer() const;
    bool IsSpacer() const;

    void SetProportion(int proportion);
    int GetProportion() const;
    void SetFlag(int flag);
    int GetFlag() const;
    void SetBorder(int border);
    int GetBorder() const;

    wxWindow *GetWindow() const;
    wxSizer *GetSizer() const;
    wxSize GetSpacer() const;

    // This function behaves obviously for the windows and spacers but for the
    // sizers it returns true if any sizer element is shown and only returns
    // false if all of them are hidden. Also, it always returns true if
    // wxRESERVE_SPACE_EVEN_IF_HIDDEN flag was used.
    bool IsShown() const;

    void Show(bool show);

    void SetUserData(%ungc wxObject* userData);
    wxObject* GetUserData() const;
    wxPoint GetPosition() const;

    // Called once the first component of an item has been decided. This is
    // used in algorithms that depend on knowing the size in one direction
    // before the min size in the other direction can be known.
    // Returns true if it made use of the information (and min size was changed).
    bool InformFirstDirection(int direction, int size, int availableOtherDir = -1);

    // these functions delete the current contents of the item if it's a sizer
    // or a spacer but not if it is a window
    void AssignWindow(wxWindow *window);
    void AssignSizer(wxSizer *sizer);
    void AssignSpacer(const wxSize& size);
    void AssignSpacer(int w, int h);
};

//---------------------------------------------------------------------------
// wxSizer
//---------------------------------------------------------------------------

class wxSizer: public wxObject, public wxClientDataContainer
{
public:
    // base class no constructors
    // wxSizer();

    // methods for adding elements to the sizer: there are Add/Insert/Prepend
    // overloads for each of window/sizer/spacer/wxSizerItem
    wxSizerItem* Add(wxWindow *window, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Add(wxSizer *sizer, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Add(int width, int height, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Add( wxWindow *window, const wxSizerFlags& flags);
    wxSizerItem* Add( wxSizer *sizer, const wxSizerFlags& flags);
    wxSizerItem* Add( int width, int height, const wxSizerFlags& flags);
    wxSizerItem* Add( wxSizerItem *item);

    virtual wxSizerItem *AddSpacer(int size);
    wxSizerItem* AddStretchSpacer(int prop = 1);

    wxSizerItem* Insert(size_t index, wxWindow *window, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Insert(size_t index, wxSizer *sizer, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Insert(size_t index, int width, int height, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Insert(size_t index, wxWindow *window, const wxSizerFlags& flags);
    wxSizerItem* Insert(size_t index, wxSizer *sizer, const wxSizerFlags& flags);
    wxSizerItem* Insert(size_t index, int width, int height, const wxSizerFlags& flags);

    // NB: do _not_ override this function in the derived classes, this one is
    //     virtual for compatibility reasons only to allow old code overriding
    //     it to continue to work, override DoInsert() instead in the new code
    virtual wxSizerItem* Insert(size_t index, wxSizerItem *item);

    wxSizerItem* InsertSpacer(size_t index, int size);
    wxSizerItem* InsertStretchSpacer(size_t index, int prop = 1);

    wxSizerItem* Prepend(wxWindow *window, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Prepend(wxSizer *sizer, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Prepend(int width, int height, int proportion = 0, int flag = 0, int border = 0, %ungc wxObject* userData = NULL);
    wxSizerItem* Prepend(wxWindow *window, const wxSizerFlags& flags);
    wxSizerItem* Prepend(wxSizer *sizer, const wxSizerFlags& flags);
    wxSizerItem* Prepend(int width, int height, const wxSizerFlags& flags);
    wxSizerItem* Prepend(wxSizerItem *item);

    wxSizerItem* PrependSpacer(int size);
    wxSizerItem* PrependStretchSpacer(int prop = 1);

    // set (or possibly unset if window is NULL) or get the window this sizer
    // is used in
    void SetContainingWindow(wxWindow *window);
    wxWindow *GetContainingWindow() const;

    virtual bool Remove(wxSizer *sizer);
    virtual bool Remove(int index);

    virtual bool Detach(wxWindow *window);
    virtual bool Detach(wxSizer *sizer);
    virtual bool Detach(int index);

    virtual bool Replace(wxWindow *oldwin, wxWindow *newwin, bool recursive = false);
    virtual bool Replace(wxSizer *oldsz, wxSizer *newsz, bool recursive = false);
    virtual bool Replace(size_t index, wxSizerItem *newitem);

    virtual void Clear( bool delete_windows = false);
    virtual void DeleteWindows();

    // Inform sizer about the first direction that has been decided (by parent item)
    // Returns true if it made use of the information (and recalculated min size)
    virtual bool InformFirstDirection( int direction, int size, int availableOtherDir);

    void SetMinSize(int width, int height);
    void SetMinSize(const wxSize& size);

    // Searches recursively
    bool SetItemMinSize(wxWindow *window, int width, int height);
    bool SetItemMinSize(wxWindow *window, const wxSize& size);

    // Searches recursively
    bool SetItemMinSize(wxSizer *sizer, int width, int height);
    bool SetItemMinSize(wxSizer *sizer, const wxSize& size);

    bool SetItemMinSize(size_t index, int width, int height);
    bool SetItemMinSize(size_t index, const wxSize& size);

    wxSize GetSize() const;
    wxPoint GetPosition() const;

    // Calculate the minimal size or return m_minSize if bigger.
    wxSize GetMinSize();

    virtual void Layout();

    wxSize ComputeFittingClientSize(wxWindow *window);
    wxSize ComputeFittingWindowSize(wxWindow *window);

    wxSize Fit( wxWindow *window );
    void FitInside( wxWindow *window );
    void SetSizeHints( wxWindow *window );

    wxSizerItemList& GetChildren();
    const wxSizerItemList& GetChildren() const;

    void SetDimension(const wxPoint& pos, const wxSize& size);
    void SetDimension(int x, int y, int width, int height);

    size_t GetItemCount() const;
    bool IsEmpty() const;

    wxSizerItem* GetItem(wxWindow *window, bool recursive = false);
    wxSizerItem* GetItem(wxSizer *sizer, bool recursive = false);
    wxSizerItem* GetItem(size_t index);
    wxSizerItem* GetItemById(int id, bool recursive = false);

    // Manage whether individual scene items are considered
    // in the layout calculations or not.
    bool Show(wxWindow *window, bool show = true, bool recursive = false);
    bool Show(wxSizer *sizer, bool show = true, bool recursive = false);
    bool Show(size_t index, bool show = true);

    bool Hide(wxSizer *sizer, bool recursive = false);
    bool Hide(wxWindow *window, bool recursive = false);
    bool Hide(size_t index)£»

    bool IsShown(wxWindow *window) const;
    bool IsShown(wxSizer *sizer) const;
    bool IsShown(size_t index) const;

    // Recursively call wxWindow::Show () on all sizer items.
    virtual void ShowItems (bool show);

    void Show(bool show);

    // This is the ShowItems() counterpart and returns true if any of the sizer
    // items are shown.
    virtual bool AreAnyItemsShown() const;
}



#if %wxchkver_2_8









// ---------------------------------------------------------------------------
// wxSizerItemList

//#if wxLUA_USE_wxSizerItemList && !wxUSE_STL

class wxSizerItemList : public wxList
{
    //wxSizerItemList() - no constructor, just get this from wxSizer::GetChildren( );

    // This is returned from wxSizer::GetChildren(), use wxList methods and
    //   wxNode::GetData():DynamicCast("wxSizer") to retrieve the wxSizer

    // Use the wxList methods, see also wxNode
};

//#endif //wxLUA_USE_wxSizerItemList && !wxUSE_STL

// ---------------------------------------------------------------------------
// wxBoxSizer

class wxBoxSizer : public wxSizer
{
    wxBoxSizer(int orient );

    //void RecalcSizes( );
    //wxSize CalcMin( );
    int GetOrientation( );
};

// ---------------------------------------------------------------------------
// wxGridSizer

class wxGridSizer : public wxSizer
{
    wxGridSizer(int cols, int rows, int vgap, int hgap );
    // wxGridSizer(int cols, int vgap = 0, int hgap = 0 );

    int GetCols( );
    int GetHGap( );
    int GetRows( );
    int GetVGap( );
    void SetCols(int cols );
    void SetHGap(int gap );
    void SetRows(int rows );
    void SetVGap(int gap );
};

// ---------------------------------------------------------------------------
// wxFlexGridSizer

enum wxFlexSizerGrowMode
{
    wxFLEX_GROWMODE_NONE,
    wxFLEX_GROWMODE_SPECIFIED,
    wxFLEX_GROWMODE_ALL
};

class wxFlexGridSizer : public wxGridSizer
{
    wxFlexGridSizer(int rows, int cols, int vgap=0, int hgap=0 );
    // wxFlexGridSizer(int cols, int vgap = 0, int hgap = 0); // just use the above constructor

    void AddGrowableCol( size_t idx, int proportion = 0 );
    void AddGrowableRow( size_t idx, int proportion = 0 );
    int GetFlexibleDirection() const;
    wxFlexSizerGrowMode GetNonFlexibleGrowMode() const;
    void RemoveGrowableCol( size_t idx );
    void RemoveGrowableRow( size_t idx );
    void SetFlexibleDirection(int direction );
    void SetNonFlexibleGrowMode(wxFlexSizerGrowMode mode );
};

// ---------------------------------------------------------------------------
// wxGridBagSizer

#include "wx/gbsizer.h"

class wxGridBagSizer : public wxFlexGridSizer
{
    wxGridBagSizer(int vgap=0, int hgap=0 );

    wxSizerItem* Add(wxWindow* window, const wxGBPosition& pos, const wxGBSpan& span = wxDefaultSpan, int flag = 0, int border = 0, %ungc wxObject* userData = NULL );
    wxSizerItem* Add(wxSizer* sizer, const wxGBPosition& pos, const wxGBSpan& span = wxDefaultSpan, int flag = 0, int border = 0, %ungc wxObject* userData = NULL );
    wxSizerItem* Add(int width, int height, const wxGBPosition& pos, const wxGBSpan& span = wxDefaultSpan, int flag = 0, int border = 0, %ungc wxObject* userData = NULL );
    wxSizerItem* Add(wxGBSizerItem* item );

    bool CheckForIntersection(wxGBSizerItem* item, wxGBSizerItem* excludeItem = NULL );
    bool CheckForIntersection(const wxGBPosition& pos, const wxGBSpan& span, wxGBSizerItem* excludeItem = NULL );

    wxGBSizerItem* FindItem(wxWindow* window );
    wxGBSizerItem* FindItem(wxSizer* sizer );
    wxGBSizerItem*  FindItemAtPoint(const wxPoint& pt );
    wxGBSizerItem*  FindItemAtPosition(const wxGBPosition& pos );
    wxGBSizerItem*  FindItemWithData(const wxObject* userData );
    wxSize GetCellSize(int row, int col) const;
    wxSize GetEmptyCellSize() const;

    wxGBPosition  GetItemPosition(wxWindow* window );
    wxGBPosition  GetItemPosition(wxSizer* sizer );
    wxGBPosition  GetItemPosition(size_t index );

    wxGBSpan GetItemSpan(wxWindow* window );
    wxGBSpan GetItemSpan(wxSizer* sizer );
    wxGBSpan GetItemSpan(size_t index );
    //void RecalcSizes( );
    void SetEmptyCellSize(const wxSize& sz );
    bool SetItemPosition(wxWindow* window, const wxGBPosition& pos );
    bool SetItemPosition(wxSizer* sizer, const wxGBPosition& pos );
    bool SetItemPosition(size_t index, const wxGBPosition& pos );
    bool SetItemSpan(wxWindow* window, const wxGBSpan& span );
    bool SetItemSpan(wxSizer* sizer, const wxGBSpan& span );
    bool SetItemSpan(size_t index, const wxGBSpan& span );
};

// ---------------------------------------------------------------------------
// wxGBPosition

class %delete wxGBPosition
{
    wxGBPosition(int row=0, int col=0 );
    wxGBPosition(const wxGBPosition& pos );

    int GetRow() const;
    int GetCol() const;
    void SetRow(int row );
    void SetCol(int col );

    bool operator==(const wxGBPosition& p) const;
};

// ---------------------------------------------------------------------------
// wxGBSpan

class %delete wxGBSpan
{
    wxGBSpan(int rowspan=1, int colspan=1 );
    wxGBSpan(const wxGBSpan& span );

    int GetRowspan() const;
    int GetColspan() const;
    void SetRowspan(int rowspan );
    void SetColspan(int colspan );

    bool operator==(const wxGBSpan& o) const;
};

// ---------------------------------------------------------------------------
// wxGBSizerItem

class wxGBSizerItem : public wxSizerItem
{
    wxGBSizerItem( );
    wxGBSizerItem( int width, int height, const wxGBPosition& pos, const wxGBSpan& span, int flag, int border, %ungc wxObject* userData );
    wxGBSizerItem( wxWindow *window, const wxGBPosition& pos, const wxGBSpan& span, int flag, int border, %ungc wxObject* userData );
    wxGBSizerItem( wxSizer *sizer, const wxGBPosition& pos, const wxGBSpan& span, int flag, int border, %ungc wxObject* userData );

    wxGBPosition GetPos() const;
    //void GetPos(int& row, int& col) const;
    wxGBSpan GetSpan() const;
    //void GetSpan(int& rowspan, int& colspan) const;
    bool SetPos( const wxGBPosition& pos );
    bool SetSpan( const wxGBSpan& span );
    bool Intersects(const wxGBSizerItem& other );
    bool Intersects(const wxGBPosition& pos, const wxGBSpan& span );

    // %override [row, col] wxGBSizerItem::GetEndPos( );
    // C++ Func: void GetEndPos(int& row, int& col );
    void GetEndPos( );

    wxGridBagSizer* GetGBSizer() const;
    void SetGBSizer(wxGridBagSizer* sizer );
};

// ---------------------------------------------------------------------------
// wxWrapSizer

#if %wxchkver_2_9

#include "wx/wrapsizer.h"

enum
{
    wxEXTEND_LAST_ON_EACH_LINE,
    wxREMOVE_LEADING_SPACES,
    wxWRAPSIZER_DEFAULT_FLAGS
};

class wxWrapSizer : public wxBoxSizer
{
    wxWrapSizer(int orient = wxHORIZONTAL, int flags = wxWRAPSIZER_DEFAULT_FLAGS);
    
    // This will probably not be needed to be called by user code.
    bool InformFirstDirection(int direction, int size, int availableOtherDir);
};

#endif

// ---------------------------------------------------------------------------
// wxNotebookSizer - deprecated

#if wxUSE_NOTEBOOK && (!%wxchkver_2_6 );

class wxNotebookSizer : public wxSizer
{
    wxNotebookSizer(wxNotebook* notebook );
    wxNotebook* GetNotebook( );
};

#endif //wxUSE_NOTEBOOK && (!%wxchkver_2_6 );

// ---------------------------------------------------------------------------
// wxBookCtrlSizer - also depricated since 2.6

// ---------------------------------------------------------------------------
// wxStaticBoxSizer

#if wxUSE_STATBOX

class wxStaticBoxSizer : public wxBoxSizer
{
    wxStaticBoxSizer(wxStaticBox* box, int orient );
    wxStaticBoxSizer(int orient, wxWindow *parent, const wxString& label = "" );

    wxStaticBox* GetStaticBox( );
};

#endif //wxUSE_STATBOX

// ---------------------------------------------------------------------------
// wxStdDialogButtonSizer

#if wxUSE_BUTTON

class wxStdDialogButtonSizer : public wxBoxSizer
{
    wxStdDialogButtonSizer( );

    void AddButton(wxButton *button );
    void SetAffirmativeButton( wxButton *button );
    void SetNegativeButton( wxButton *button );
    void SetCancelButton( wxButton *button );

    void Realize( );

    wxButton *GetAffirmativeButton() const;
    wxButton *GetApplyButton() const;
    wxButton *GetNegativeButton() const;
    wxButton *GetCancelButton() const;
    wxButton *GetHelpButton() const;
};

#endif //wxUSE_BUTTON

#endif //wxLUA_USE_wxSizer

// ---------------------------------------------------------------------------
// wxLayoutConstraints - deprecated since 2.2, not updated to 2.6

#if wxLUA_USE_wxLayoutConstraints && (!%wxchkver_2_6 );

#include "wx/layout.h"

enum wxRelationship
{
    wxUnconstrained,
    wxAsIs,
    wxPercentOf,
    wxAbove,
    wxBelow,
    wxLeftOf,
    wxRightOf,
    wxSameAs,
    wxAbsolute
};

enum wxEdge
{
    wxLeft,
    wxTop,
    wxRight,
    wxBottom,
    wxWidth,
    wxHeight,
    wxCentre,
    wxCenter,
    wxCentreX,
    wxCentreY
};

class wxLayoutConstraints : public wxObject
{
    wxLayoutConstraints( );
};

// ---------------------------------------------------------------------------
// wxIndividualLayoutConstraint

#include "wx/layout.h"

class wxIndividualLayoutConstraint : public wxObject
{
    wxIndividualLayoutConstraint( );
    void Above(wxWindow *otherWin, int margin = 0 );
    void Absolute(int value );
    void AsIs( );
    void Below(wxWindow *otherWin, int margin = 0 );
    void Unconstrained( );
    void LeftOf(wxWindow *otherWin, int margin = 0 );
    void PercentOf(wxWindow *otherWin, wxEdge edge, int per );
    void RightOf(wxWindow *otherWin, int margin = 0 );
    void SameAs(wxWindow *otherWin, wxEdge edge, int margin = 0 );
    void Set(wxRelationship rel, wxWindow *otherWin, wxEdge otherEdge, int value = 0, int margin = 0 );
};

#endif //wxLUA_USE_wxLayoutConstraints && (!%wxchkver_2_6 );

