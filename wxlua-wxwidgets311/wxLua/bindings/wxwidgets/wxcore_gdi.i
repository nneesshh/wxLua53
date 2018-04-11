// ===========================================================================
// Purpose:     GDI classes, Colour, Pen, Brush, Font, DC, Bitmap...
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

// ---------------------------------------------------------------------------
// wxPoint

#if wxLUA_USE_wxPointSizeRect

#include "wx/gdicmn.h"

#define wxDefaultCoord

#define_object wxPoint wxDefaultPosition

class %delete wxPoint
{
    //#define_object wxDefaultPosition

    wxPoint(int x = 0, int y = 0);
    wxPoint(const wxPoint& pt);

    // %override [int x, int y] wxPoint::GetXY();
    // wxLua added function
    int GetXY() const;

    // %override void wxPoint::Set(int x, int y);
    // wxLua added function
    void Set(int x, int y);

    %rename X %member_func int x; // GetX() and SetX(int x);
    %rename Y %member_func int y; // GetY() and SetY(int y);

    wxPoint& operator=(const wxPoint& p) const;

    bool operator==(const wxPoint& p) const; //{ return x == p.x && y == p.y; }
    bool operator!=(const wxPoint& p) const; //{ return !(*this == p); }

    // arithmetic operations (component wise);
    wxPoint operator+(const wxPoint& p) const; //{ return wxPoint(x + p.x, y + p.y); }
    wxPoint operator-(const wxPoint& p) const; //{ return wxPoint(x - p.x, y - p.y); }

    wxPoint& operator+=(const wxPoint& p); //{ x += p.x; y += p.y; return *this; }
    wxPoint& operator-=(const wxPoint& p); //{ x -= p.x; y -= p.y; return *this; }

    wxPoint& operator+=(const wxSize& s); //{ x += s.GetWidth(); y += s.GetHeight(); return *this; }
    wxPoint& operator-=(const wxSize& s); //{ x -= s.GetWidth(); y -= s.GetHeight(); return *this; }

    wxPoint operator+(const wxSize& s) const; //{ return wxPoint(x + s.GetWidth(), y + s.GetHeight()); }
    wxPoint operator-(const wxSize& s) const; //{ return wxPoint(x - s.GetWidth(), y - s.GetHeight()); }

    wxPoint operator-() const; //{ return wxPoint(-x, -y); }
};

// ---------------------------------------------------------------------------
// wxPointList

//class %delete wxPointList : public wxObjectList
//{
//    wxPointList();
//};

// ---------------------------------------------------------------------------
// wxRealPoint - Used nowhere in wxWidgets

//class %delete wxRealPoint
//{
//    wxRealPoint(double xx = 0, double yy = 0);
//
//    %rename X double x; // GetX() and SetX(int x);
//    %rename Y double y; // GetY() and SetY(int y);
//};

// ---------------------------------------------------------------------------
// wxSize

class %delete wxSize
{
    #define_object wxDefaultSize

    wxSize(int width = 0, int height = 0);
    wxSize(const wxSize& size);

    void DecBy(int dx, int dy);
    //void DecBy(const wxSize& sz);
    //void DecBy(int d);
    void DecTo(const wxSize& sz);
    bool IsFullySpecified() const;
    int GetHeight() const;
    int GetWidth() const;
    void IncBy(int dx, int dy);
    //void IncBy(const wxSize& sz);
    //void IncBy(int d);
    void IncTo(const wxSize& sz);
    wxSize& Scale(float xscale, float yscale);
    void Set(int width, int height);
    void SetDefaults(const wxSize& size);
    void SetHeight(int height);
    void SetWidth(int width);

    wxSize& operator=(const wxSize& s) const;

    bool operator==(const wxSize& sz) const; //{ return x == sz.x && y == sz.y; }
    bool operator!=(const wxSize& sz) const; //{ return x != sz.x || y != sz.y; }

    wxSize operator+(const wxSize& sz) const; //{ return wxSize(x + sz.x, y + sz.y); }
    wxSize operator-(const wxSize& sz) const; //{ return wxSize(x - sz.x, y - sz.y); }
    wxSize operator/(int i) const; //{ return wxSize(x / i, y / i); }
    wxSize operator*(int i) const; //{ return wxSize(x * i, y * i); }

    wxSize& operator+=(const wxSize& sz); //{ x += sz.x; y += sz.y; return *this; }
    wxSize& operator-=(const wxSize& sz); //{ x -= sz.x; y -= sz.y; return *this; }
    wxSize& operator/=(const int i);      //{ x /= i; y /= i; return *this; }
    wxSize& operator*=(const int i);      //{ x *= i; y *= i; return *this; }
};

// ---------------------------------------------------------------------------
// wxRect

class %delete wxRect
{
    wxRect(int x = 0, int y = 0, int w = 0, int h = 0);
    wxRect(const wxRect& rect);
    wxRect(const wxPoint& topLeft, const wxPoint& bottomRight);
    wxRect(const wxPoint& pos, const wxSize& size);
    wxRect(const wxSize& size);

    wxRect CentreIn(const wxRect& r, int dir = wxBOTH) const; // CenterIn
    bool Contains(wxCoord dx, wxCoord dy) const;
    bool Contains(const wxPoint& pt) const;
    bool Contains(const wxRect& rect) const;

    wxRect  Deflate(wxCoord dx, wxCoord dy) const; //wxRect& Deflate(wxCoord dx, wxCoord dy);
    int     GetBottom();
    int     GetHeight();
    int     GetLeft();
    wxPoint GetPosition();
    wxPoint GetTopLeft() const;                  // GetLeftTop
    wxPoint GetTopRight() const;   // GetRightTop
    wxPoint GetBottomRight() const;              // GetRightBottom
    wxPoint GetBottomLeft() const; // GetLeftBottom
    int     GetRight();
    wxSize  GetSize();
    int     GetTop();
    int     GetWidth();
    int     GetX();
    int     GetY();
    wxRect  Inflate(wxCoord dx, wxCoord dy) const; //wxRect& Inflate(wxCoord dx, wxCoord dy);
    %wxcompat_2_6 bool    Inside(wxCoord cx, wxCoord cy);
    bool    Intersects(const wxRect& rect) const;
    bool    IsEmpty() const;
    void    Offset(wxCoord dx, wxCoord dy);  //void Offset(const wxPoint& pt);
    void    SetBottom(int bottom);
    void    SetHeight(int height);
    void    SetLeft(int left);
    void    SetPosition(const wxPoint &p);
    void    SetBottomLeft(const wxPoint &p);   // SetLeftBottom
    void    SetBottomRight(const wxPoint &p);                // SetRightBottom
    void    SetRight(int right);
    void    SetSize(const wxSize &s);
    void    SetTop(int top);
    void    SetTopRight(const wxPoint &p);     // SetRightTop
    void    SetWidth(int width);
    void    SetX(int X);
    void    SetY(int Y);
    wxRect  Union(const wxRect& rect) const; //wxRect& Union(const wxRect& rect);

    wxRect& operator=(const wxRect& r) const;

    bool operator==(const wxRect& rect) const;
    wxRect operator+(const wxRect& rect) const;
    wxRect& operator+=(const wxRect& rect);
};

#endif //wxLUA_USE_wxPointSizeRect

// ---------------------------------------------------------------------------
// wxGDIObject

class %delete wxGDIObject : public wxObject
{
    bool IsNull();
};

// ---------------------------------------------------------------------------
// wxRegion

#if wxLUA_USE_wxRegion

#include "wx/region.h"

enum wxRegionContain
{
    wxOutRegion,
    wxPartRegion,
    wxInRegion
};

#if defined(wxHAS_REGION_COMBINE); // MSW and MAC
    enum wxRegionOp
    {
        wxRGN_AND,   // Creates the intersection of the two combined regions.
        wxRGN_COPY,  // Creates a copy of the region
        wxRGN_DIFF,  // Combines the parts of first region that are not in the second one
        wxRGN_OR,    // Creates the union of two combined regions.
        wxRGN_XOR    // Creates the union of two regions except for any overlapping areas.
    };

#define wxHAS_REGION_COMBINE 1
#endif // defined(wxHAS_REGION_COMBINE);

class %delete wxRegion : public wxGDIObject
{
    wxRegion(long x = 0, long y = 0, long width = 0, long height = 0);
    wxRegion(const wxPoint& topLeft, const wxPoint& bottomRight);
    // wxRegion(const wxPoint& pos, const wxSize& size);
    wxRegion(const wxRect& rect);
    wxRegion(const wxRegion& region);

    void Clear();

#if defined(wxHAS_REGION_COMBINE); // MSW and MAC
    bool Combine(wxCoord x, wxCoord y, wxCoord w, wxCoord h, wxRegionOp op);
    bool Combine(const wxRect& rect, wxRegionOp op);
    bool Combine(const wxRegion& region, wxRegionOp op);
#endif // defined(wxHAS_REGION_COMBINE);

    wxRegionContain Contains(long x, long y);
    wxRegionContain Contains(const wxPoint& pt);
    wxRegionContain Contains(const wxRect& rect);
    wxRegionContain Contains(long x, long y, long w, long h);
    wxBitmap ConvertToBitmap() const;
    wxRect GetBox() const;

    // %override [int x, int y, int width, int height] wxRegion::GetBoxXYWH();
    // C++ Func: void GetBox(int &x, int &y, int &width, int &height);
    %rename GetBoxXYWH void GetBox();

    bool Intersect(long x, long y, long width, long height);
    bool Intersect(const wxRect& rect);
    bool Intersect(const wxRegion& region);
    bool IsEmpty() const;
    bool IsEqual(const wxRegion& region) const;
    bool Ok() const;
    bool Subtract(long x, long y, long width, long height);
    bool Subtract(const wxRect& rect);
    bool Subtract(const wxRegion& region);
    bool Offset(wxCoord x, wxCoord y);
    bool Union(long x, long y, long width, long height);
    bool Union(const wxRect& rect);
    bool Union(const wxRegion& region);
    bool Union(const wxBitmap& bmp);
    bool Union(const wxBitmap& bmp, const wxColour& transColour, int tolerance = 0);
    bool Xor(long x, long y, long width, long height);
    bool Xor(const wxRect& rect);
    bool Xor(const wxRegion& region);

    wxRegion& operator=(const wxRegion& r) const;
    // operator == just calls IsEqual();
};

// ---------------------------------------------------------------------------
// wxRegionIterator

class %delete wxRegionIterator : public wxObject
{
    wxRegionIterator(const wxRegion& region);

    long GetX();
    long GetY();
    long GetWidth();     // long GetW();
    long GetHeight();    // long GetH();
    wxRect GetRect();
    bool HaveRects();
    void Reset();

    // %override wxRegionIterator::Next() is ++ operator
    // This is a wxLua added function.
    void Next();         // operator++
};

#endif //wxLUA_USE_wxRegion

// ---------------------------------------------------------------------------
// wxFont

#if wxLUA_USE_wxFont

#include "wx/font.h"

enum
{
    wxDEFAULT,      // these are deprecated use wxFONTFAMILY_XXX
    wxDECORATIVE,
    wxROMAN,
    wxSCRIPT,
    wxSWISS,
    wxMODERN,
    wxTELETYPE,

    wxVARIABLE,      // unused ?
    wxFIXED,         // unused ?

    wxNORMAL,
    wxLIGHT,
    wxBOLD,
    wxITALIC,
    wxSLANT
};

enum wxFontFamily
{
    wxFONTFAMILY_DEFAULT,
    wxFONTFAMILY_DECORATIVE,
    wxFONTFAMILY_ROMAN,
    wxFONTFAMILY_SCRIPT,
    wxFONTFAMILY_SWISS,
    wxFONTFAMILY_MODERN,
    wxFONTFAMILY_TELETYPE,
    wxFONTFAMILY_MAX,
    wxFONTFAMILY_UNKNOWN
};

enum wxFontStyle
{
    wxFONTSTYLE_NORMAL,
    wxFONTSTYLE_ITALIC,
    wxFONTSTYLE_SLANT,
    wxFONTSTYLE_MAX
};

enum wxFontWeight
{
    wxFONTWEIGHT_NORMAL,
    wxFONTWEIGHT_LIGHT,
    wxFONTWEIGHT_BOLD,
    wxFONTWEIGHT_MAX
};

enum
{
    wxFONTFLAG_DEFAULT,
    wxFONTFLAG_ITALIC,
    wxFONTFLAG_SLANT,
    wxFONTFLAG_LIGHT,
    wxFONTFLAG_BOLD,
    wxFONTFLAG_ANTIALIASED,
    wxFONTFLAG_NOT_ANTIALIASED,
    wxFONTFLAG_UNDERLINED,
    wxFONTFLAG_STRIKETHROUGH,
    wxFONTFLAG_MASK
};

enum wxFontSymbolicSize
{
    wxFONTSIZE_XX_SMALL = -3,   //!< Extra small.
    wxFONTSIZE_X_SMALL,         //!< Very small.
    wxFONTSIZE_SMALL,           //!< Small.
    wxFONTSIZE_MEDIUM,          //!< Normal.
    wxFONTSIZE_LARGE,           //!< Large.
    wxFONTSIZE_X_LARGE,         //!< Very large.
    wxFONTSIZE_XX_LARGE         //!< Extra large.
};

class wxFontInfo
{
    wxFontInfo();
    wxFontInfo(int pointSize);
    wxFontInfo(const wxSize& pixelSize);
    wxFontInfo& Family(wxFontFamily family);
    wxFontInfo& FaceName(const wxString& faceName);
    wxFontInfo& Bold(bool bold = true);
    wxFontInfo& Light(bool light = true);
    wxFontInfo& Italic(bool italic = true);
    wxFontInfo& Slant(bool slant = true);
    wxFontInfo& AntiAliased(bool antiAliased = true);
    wxFontInfo& Underlined(bool underlined = true);
    wxFontInfo& Strikethrough(bool strikethrough = true);
    wxFontInfo& Encoding(wxFontEncoding encoding);
    wxFontInfo& AllFlags(int flags);
};

class %delete wxFont : public wxGDIObject
{
    #define_object wxNullFont
    %rename wxNORMAL_FONT #define_pointer wxLua_wxNORMAL_FONT // hack for wxWidgets >2.7
    %rename wxSMALL_FONT  #define_pointer wxLua_wxSMALL_FONT
    %rename wxITALIC_FONT #define_pointer wxLua_wxITALIC_FONT
    %rename wxSWISS_FONT  #define_pointer wxLua_wxSWISS_FONT
    wxFont();
    wxFont(const wxFont& font);
    wxFont(const wxFontInfo& font);
    wxFont(int pointSize, wxFontFamily family, wxFontStyle style, wxFontWeight weight, bool underline = false, const wxString& faceName = wxEmptyString, wxFontEncoding encoding = wxFONTENCODING_DEFAULT);
    wxFont(const wxSize& pixelSize, wxFontFamily family, wxFontStyle style, wxFontWeight weight, bool underline = false, const wxString& faceName = wxEmptyString, wxFontEncoding encoding = wxFONTENCODING_DEFAULT);
    wxFont(const wxString& nativeInfoString);
    wxFont(const wxNativeFontInfo& nativeInfo);
    wxFont GetBaseFont() const;
    wxFontEncoding GetEncoding() const;
    wxString GetFaceName() const;
    int      GetFamily() const;
    wxString GetNativeFontInfoDesc() const;
    wxString GetNativeFontInfoUserDesc() const;
    const wxNativeFontInfo *GetNativeFontInfo() const;
    int      GetPointSize() const;
    wxSize GetPixelSize() const;
    int      GetStyle() const;
    bool     GetUnderlined() const;
    bool GetStrikethrough() const;
    int      GetWeight() const;
    bool IsFixedWidth() const;
    bool IsOk() const;
    wxFont Bold() const;
    wxFont Italic() const;
    wxFont Larger() const;
    wxFont Smaller() const;
    wxFont Underlined() const;
    wxFont Strikethrough() const;
    wxFont& MakeBold();
    wxFont& MakeItalic();
    wxFont& MakeLarger();
    wxFont& MakeSmaller();
    wxFont& MakeUnderlined();
    wxFont& MakeStrikethrough();
    wxFont& Scale(float x);
    wxFont Scaled(float x) const;
    void SetEncoding(wxFontEncoding encoding);
    %not_overload bool SetFaceName(const wxString& faceName);
    void SetFamily(wxFontFamily family);
    %not_overload bool SetNativeFontInfo(const wxString& info);
    bool SetNativeFontInfoUserDesc(const wxString& info);
    void     SetPointSize(int pointSize);
    void SetPixelSize(const wxSize& pixelSize);
    void SetStyle(wxFontStyle style);
    void SetSymbolicSize(wxFontSymbolicSize size);
    void SetSymbolicSizeRelativeTo(wxFontSymbolicSize size, int base);
    void SetUnderlined(bool underlined);
    void SetStrikethrough(bool strikethrough);
    void SetWeight(wxFontWeight weight);
    bool operator!=(const wxFont& font) const;
    bool operator==(const wxFont& font) const;
    wxFont& operator =(const wxFont& font);
    static wxFontEncoding GetDefaultEncoding();
    static void SetDefaultEncoding(wxFontEncoding encoding);
    static %gc wxFont* New(int pointSize, wxFontFamily family, int flags = wxFONTFLAG_DEFAULT, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT);
    static %gc wxFont* New(const wxSize& pixelSize, wxFontFamily family, int flags = wxFONTFLAG_DEFAULT, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT);
    bool Ok(); // %add for compatibility with earlier versions of wxlua
    static %gc wxFont* New(const wxSize& pixelSize, wxFontFamily family, int style, wxFontWeight weight, const bool underline = false, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT);
    static %gc wxFont* New(int pointSize, wxFontFamily family, int style, wxFontWeight weight, const bool underline = false, const wxString& faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT);
};

// ---------------------------------------------------------------------------
// wxNativeFontInfo

#include "wx/fontutil.h"

class %delete wxNativeFontInfo
{
    wxNativeFontInfo();
    wxNativeFontInfo(const wxNativeFontInfo& info);

    // accessors and modifiers for the font elements
    int GetPointSize() const;
    %msw wxSize GetPixelSize() const; // FIXME wxWidgets has undefined symbol in gtk/mac
    wxFontStyle GetStyle() const;
    wxFontWeight GetWeight() const;
    bool GetUnderlined() const;
    wxString GetFaceName() const;
    wxFontFamily GetFamily() const;
    wxFontEncoding GetEncoding() const;

    void SetPointSize(int pointsize);
    %msw void SetPixelSize(const wxSize& pixelSize);
    void SetStyle(wxFontStyle style);
    void SetWeight(wxFontWeight weight);
    void SetUnderlined(bool underlined);
    bool SetFaceName(const wxString& facename);
    void SetFamily(wxFontFamily family);
    void SetEncoding(wxFontEncoding encoding);

    // sets the first facename in the given array which is found
    // to be valid. If no valid facename is given, sets the
    // first valid facename returned by wxFontEnumerator::GetFacenames().
    // Does not return a bool since it cannot fail.
    void SetFaceName(const wxArrayString& facenames);

    // it is important to be able to serialize wxNativeFontInfo objects to be
    // able to store them (in config file, for example);
    bool FromString(const wxString& s);
    wxString ToString() const;

    // we also want to present the native font descriptions to the user in some
    // human-readable form (it is not platform independent neither, but can
    // hopefully be understood by the user);
    bool FromUserString(const wxString& s);
    wxString ToUserString() const;
};

#endif //wxLUA_USE_wxFont

// ---------------------------------------------------------------------------
// wxFontEnumerator

#if wxLUA_USE_wxFontEnumerator

#include "wx/fontenum.h"

class %delete wxFontEnumerator
{
    wxFontEnumerator();

    virtual bool EnumerateFacenames(wxFontEncoding encoding = wxFONTENCODING_SYSTEM, bool fixedWidthOnly = false);
    virtual bool EnumerateEncodings(const wxString &font = "");

    static wxArrayString GetEncodings(const wxString& facename = "");
    static wxArrayString GetFacenames(wxFontEncoding encoding = wxFONTENCODING_SYSTEM, bool fixedWidthOnly = false);

    // Use GetEncodings/Facenames after calling EnumerateXXX
    //virtual bool OnFacename(const wxString& facename);
    //virtual bool OnFontEncoding(const wxString& facename, const wxString& encoding);
};

#endif //wxLUA_USE_wxFontEnumerator

// ---------------------------------------------------------------------------
// wxFontList

#if wxLUA_USE_wxFontList

class wxFontList
{
    #define_pointer wxTheFontList

    // No constructor, use wxTheFontList

    // Note: we don't gc the returned font as the list will delete it
    wxFont* FindOrCreateFont(int pointSize, int family, int style, int weight, bool underline = false, const wxString &faceName = "", wxFontEncoding encoding = wxFONTENCODING_DEFAULT);

    // Only use FindOrCreateFont - others deprecated in >2.7
    //void AddFont(wxFont* font);
    //void RemoveFont(wxFont* font);
};

#endif //wxLUA_USE_wxFontList

// ---------------------------------------------------------------------------
// wxFontMapper

#if wxLUA_USE_wxFontMapper

#include "wx/fontmap.h"

class wxFontMapper
{
    // No constructor, use static Get() function

    wxFontEncoding CharsetToEncoding(const wxString &charset, bool interactive = true);
    static wxFontMapper *Get();

    // %override [bool, wxFontEncoding *altEncoding] wxFontMapper::GetAltForEncoding(wxFontEncoding encoding, const wxString &faceName = "", bool interactive = true);
    // C++ Func: bool GetAltForEncoding(wxFontEncoding encoding, wxFontEncoding *altEncoding, const wxString &faceName = "", bool interactive = true);
    bool GetAltForEncoding(wxFontEncoding encoding, const wxString &faceName = "", bool interactive = true);

    // This function is really for wxWidgets internal use
    // %rename GetAltForEncodingInternal bool GetAltForEncoding(wxFontEncoding encoding, wxNativeEncodingInfo *info, const wxString &faceName = "", bool interactive = true);

    static wxString GetDefaultConfigPath();
    static wxFontEncoding GetEncoding(size_t n);
    static wxString GetEncodingDescription(wxFontEncoding encoding);
    static wxFontEncoding GetEncodingFromName(const wxString& encoding);
    static wxString GetEncodingName(wxFontEncoding encoding);
    static size_t GetSupportedEncodingsCount();
    bool IsEncodingAvailable(wxFontEncoding encoding, const wxString &facename = "");
    static void Reset();
    void SetDialogParent(wxWindow *parent);
    void SetDialogTitle(const wxString &title);
    //static wxFontMapper *Set(wxFontMapper *mapper); // wxLua probably doesn't need this
    void SetConfigPath(const wxString &prefix);
};

#endif //wxLUA_USE_wxFontMapper

// ---------------------------------------------------------------------------
// wxColour

#if wxLUA_USE_wxColourPenBrush

#include "wx/colour.h"
#include "wx/gdicmn.h"

#define wxC2S_NAME          // return colour name, when possible
#define wxC2S_CSS_SYNTAX    // return colour in rgb(r,g,b) syntax
#define wxC2S_HTML_SYNTAX   // return colour in #rrggbb syntax

#define wxALPHA_TRANSPARENT
#define wxALPHA_OPAQUE

class %delete wxColour : public wxGDIObject
{
    #define_object  wxNullColour
    %rename wxBLACK      #define_pointer wxLua_wxBLACK  // hack for wxWidgets >2.7 wxStockGDI::GetColour
    %rename wxWHITE      #define_pointer wxLua_wxWHITE
    %rename wxRED        #define_pointer wxLua_wxRED
    %rename wxBLUE       #define_pointer wxLua_wxBLUE
    %rename wxGREEN      #define_pointer wxLua_wxGREEN
    %rename wxCYAN       #define_pointer wxLua_wxCYAN
    %rename wxLIGHT_GREY #define_pointer wxLua_wxLIGHT_GREY
    wxColour();
    wxColour(unsigned char red, unsigned char green, unsigned char blue, unsigned char alpha = wxALPHA_OPAQUE);
    wxColour(const wxString& colourName);
    wxColour(unsigned long colRGB);
    wxColour(const wxColour& colour);
    unsigned char Alpha() const;
    unsigned char Blue() const;
    virtual wxString GetAsString(long flags = wxC2S_NAME | wxC2S_CSS_SYNTAX) const;
    void SetRGB(wxUint32 colRGB);
    void SetRGBA(wxUint32 colRGBA);
    wxUint32 GetRGB() const;
    wxUint32 GetRGBA() const;
    // long GetPixel(); // not well supported and the return type is different to map
    unsigned char Green() const;
    bool IsOk() const;
    unsigned char Red() const;
    void Set(unsigned char red, unsigned char green, unsigned char blue, unsigned char alpha = wxALPHA_OPAQUE);
    void Set(unsigned long colRGB);
    bool Set(const wxString &str);
    bool operator !=(const wxColour& colour) const;
    wxColour& operator=(const wxColour& c) const;
    bool operator ==(const wxColour& colour) const;
    // static void MakeMono(unsigned char* r, unsigned char* g, unsigned char* b, bool on); // requires override, but easy to do in Lua
    // static void MakeDisabled(unsigned char* r, unsigned char* g, unsigned char* b, unsigned char brightness = 255); // requires override, but has an alternative version
    wxColour& MakeDisabled(unsigned char brightness = 255);
    // static void MakeGrey(unsigned char* r, unsigned char* g, unsigned char* b); // requires override, but easy to do in Lua
    // static void MakeGrey(unsigned char* r, unsigned char* g, unsigned char* b, double weight_r, double weight_g, double weight_b); // requires override, but easy to do in Lua
    static unsigned char AlphaBlend(unsigned char fg, unsigned char bg, double alpha);
    // static void ChangeLightness(unsigned char* r, unsigned char* g, unsigned char* b, int ialpha); // requires override, but has an alternative version
    wxColour ChangeLightness(int ialpha) const;
    bool Ok(); // %add for compatibility with earlier versions of wxlua
};

// ---------------------------------------------------------------------------
// wxColourDatabase

class %delete wxColourDatabase
{
    wxColourDatabase();

    wxColour Find(const wxString& name) const;
    wxString FindName(const wxColour& colour) const;
    void AddColour(const wxString& name, const wxColour& colour);
};

// ---------------------------------------------------------------------------
// wxPen

#include "wx/pen.h"

enum wxPenCap
{
    wxCAP_INVALID,
    wxCAP_BUTT,
    wxCAP_PROJECTING,
    wxCAP_ROUND
};

enum wxPenStyle
{
    wxPENSTYLE_INVALID,
    wxPENSTYLE_SOLID, /**< Solid style. */
    wxPENSTYLE_DOT, /**< Dotted style. */
    wxPENSTYLE_LONG_DASH, /**< Long dashed style. */
    wxPENSTYLE_SHORT_DASH, /**< Short dashed style. */
    wxPENSTYLE_DOT_DASH, /**< Dot and dash style. */
    wxPENSTYLE_USER_DASH, /**< Use the user dashes: see wxPen::SetDashes. */
    wxPENSTYLE_TRANSPARENT, /**< No pen is used. */
    wxPENSTYLE_STIPPLE_MASK_OPAQUE, /**< @todo WHAT's this? */
    wxPENSTYLE_STIPPLE_MASK, /**< @todo WHAT's this? */
    wxPENSTYLE_STIPPLE, /**< Use the stipple bitmap. */
    wxPENSTYLE_BDIAGONAL_HATCH, /**< Backward diagonal hatch. */
    wxPENSTYLE_CROSSDIAG_HATCH, /**< Cross-diagonal hatch. */
    wxPENSTYLE_FDIAGONAL_HATCH, /**< Forward diagonal hatch. */
    wxPENSTYLE_CROSS_HATCH, /**< Cross hatch. */
    wxPENSTYLE_HORIZONTAL_HATCH, /**< Horizontal hatch. */
    wxPENSTYLE_VERTICAL_HATCH, /**< Vertical hatch. */
    wxPENSTYLE_FIRST_HATCH, /**< First of the hatch styles (inclusive). */
    wxPENSTYLE_LAST_HATCH, /**< Last of the hatch styles (inclusive). */
    wxDOT,
    wxDOT_DASH,
    wxSOLID,
    wxLONG_DASH,
    wxSHORT_DASH,
    wxUSER_DASH
};

enum wxPenJoin
{
    wxJOIN_INVALID,
    wxJOIN_BEVEL,
    wxJOIN_MITER,
    wxJOIN_ROUND
};

enum
{
    wxTRANSPARENT,

    wxSTIPPLE_MASK_OPAQUE,
    wxSTIPPLE_MASK,
    wxSTIPPLE,
    wxBDIAGONAL_HATCH,
    wxCROSSDIAG_HATCH,
    wxFDIAGONAL_HATCH,
    wxCROSS_HATCH,
    wxHORIZONTAL_HATCH,
    wxVERTICAL_HATCH
};

class %delete wxPen : public wxGDIObject
{
    #define_object  wxNullPen
    %rename wxRED_PEN          #define_pointer wxLua_wxRED_PEN  // hack for wxWidgets >2.7 wxStockGDI::GetPen
    %rename wxCYAN_PEN         #define_pointer wxLua_wxCYAN_PEN
    %rename wxGREEN_PEN        #define_pointer wxLua_wxGREEN_PEN
    %rename wxBLACK_PEN        #define_pointer wxLua_wxBLACK_PEN
    %rename wxWHITE_PEN        #define_pointer wxLua_wxWHITE_PEN
    %rename wxTRANSPARENT_PEN  #define_pointer wxLua_wxTRANSPARENT_PEN
    %rename wxBLACK_DASHED_PEN #define_pointer wxLua_wxBLACK_DASHED_PEN
    %rename wxGREY_PEN         #define_pointer wxLua_wxGREY_PEN
    %rename wxMEDIUM_GREY_PEN  #define_pointer wxLua_wxMEDIUM_GREY_PEN
    %rename wxLIGHT_GREY_PEN   #define_pointer wxLua_wxLIGHT_GREY_PEN
    wxPen();
    wxPen(const wxColour& colour, int width, wxPenStyle style);
    %win wxPen(const wxBitmap& stipple, int width);
    wxPen(const wxPen& pen);
    wxPenCap GetCap() const;
    wxColour GetColour() const; // not wxColur& so we allocate a new one
    // int GetDashes(wxDash** dashes) const;
    wxPenJoin GetJoin() const;
    %win wxBitmap* GetStipple() const;
    wxPenStyle GetStyle() const;
    int GetWidth() const;
    bool IsOk() const;
    bool IsNonTransparent() const;
    bool IsTransparent() const;
    void SetCap(wxPenCap capStyle);
    void SetColour(wxColour& colour);
    void SetColour(unsigned char red, unsigned char green, unsigned char blue);
    // void SetDashes(int nb_dashes, const wxDash *dash);
    void SetJoin(wxPenJoin join_style);
    %win void SetStipple(const wxBitmap& stipple);
    void SetStyle(wxPenStyle style);
    void SetWidth(int width);
    bool operator!=(const wxPen& pen) const;
    wxPen& operator=(const wxPen& p) const;
    bool operator==(const wxPen& pen) const;
    bool Ok() const; // %add for compatibility with earlier versions of wxlua
};

// ---------------------------------------------------------------------------
// wxPenList

#if wxLUA_USE_wxPenList

class wxPenList //: public wxObjectList - it's not really derived from a wxList
{
    #define_pointer wxThePenList

    // No constructor, use wxThePenList

    // Note: we don't gc the returned pen as the list will delete it
    wxPen* FindOrCreatePen(const wxColour& colour, int width, int style);
};

#endif //wxLUA_USE_wxPenList

// ---------------------------------------------------------------------------
// wxBrush

#include "wx/brush.h"

enum wxBrushStyle
{
    wxBRUSHSTYLE_INVALID,
    wxBRUSHSTYLE_SOLID, /**< Solid. */
    wxBRUSHSTYLE_TRANSPARENT, /**< Transparent (no fill). */
    wxBRUSHSTYLE_STIPPLE_MASK_OPAQUE, /**< Uses a bitmap as a stipple; the mask is used for blitting monochrome using text foreground and background colors. */
    wxBRUSHSTYLE_STIPPLE_MASK, /**< Uses a bitmap as a stipple; mask is used for masking areas in the stipple bitmap. */
    wxBRUSHSTYLE_STIPPLE, /**< Uses a bitmap as a stipple. */
    wxBRUSHSTYLE_BDIAGONAL_HATCH, /**< Backward diagonal hatch. */
    wxBRUSHSTYLE_CROSSDIAG_HATCH, /**< Cross-diagonal hatch. */
    wxBRUSHSTYLE_FDIAGONAL_HATCH, /**< Forward diagonal hatch. */
    wxBRUSHSTYLE_CROSS_HATCH, /**< Cross hatch. */
    wxBRUSHSTYLE_HORIZONTAL_HATCH, /**< Horizontal hatch. */
    wxBRUSHSTYLE_VERTICAL_HATCH, /**< Vertical hatch. */
    wxBRUSHSTYLE_FIRST_HATCH, /**< First of the hatch styles (inclusive). */
    wxBRUSHSTYLE_LAST_HATCH /**< Last of the hatch styles (inclusive). */
};

class %delete wxBrush : public wxGDIObject
{
    #define_object  wxNullBrush
    %rename wxBLUE_BRUSH        #define_pointer wxLua_wxBLUE_BRUSH // hack for wxWidgets >2.7 wxStockGDI::GetBrush
    %rename wxGREEN_BRUSH       #define_pointer wxLua_wxGREEN_BRUSH
    %rename wxWHITE_BRUSH       #define_pointer wxLua_wxWHITE_BRUSH
    %rename wxBLACK_BRUSH       #define_pointer wxLua_wxBLACK_BRUSH
    %rename wxGREY_BRUSH        #define_pointer wxLua_wxGREY_BRUSH
    %rename wxMEDIUM_GREY_BRUSH #define_pointer wxLua_wxMEDIUM_GREY_BRUSH
    %rename wxLIGHT_GREY_BRUSH  #define_pointer wxLua_wxLIGHT_GREY_BRUSH
    %rename wxTRANSPARENT_BRUSH #define_pointer wxLua_wxTRANSPARENT_BRUSH
    %rename wxCYAN_BRUSH        #define_pointer wxLua_wxCYAN_BRUSH
    %rename wxRED_BRUSH         #define_pointer wxLua_wxRED_BRUSH
    wxBrush();
    wxBrush(const wxColour& colour, wxBrushStyle style = wxBRUSHSTYLE_SOLID);
    wxBrush(const wxBitmap& stippleBitmap);
    wxBrush(const wxBrush& brush);
    wxColour GetColour() const;
    wxBitmap* GetStipple() const;
    int GetStyle() const;
    bool IsHatch() const;
    bool IsOk() const;
    bool IsNonTransparent() const;
    bool IsTransparent() const;
    void SetColour(const wxColour& colour);
    void SetColour(unsigned char red, unsigned char green, unsigned char blue);
    void SetStipple(const wxBitmap& bitmap);
    void SetStyle(wxBrushStyle style);
    bool operator !=(const wxBrush& brush) const;
    bool operator ==(const wxBrush& brush) const;
    bool Ok() const; // %add for compatibility with earlier versions of wxlua
};

// ---------------------------------------------------------------------------
// wxBrushList

#if wxLUA_USE_wxBrushList

class wxBrushList // : public wxObjectList - it's not really derived from it
{
    #define_pointer wxTheBrushList

    // No constructor, use wxTheBrushList

    // Note: we don't gc the returned brush as the list will delete it
    wxBrush* FindOrCreateBrush(const wxColour& colour, int style);

    // Use the wxList methods, see also wxNode
    //void AddBrush(wxBrush *brush)    internal use for wxWidgets
    //void RemoveBrush(wxBrush *brush);
};

#endif //wxLUA_USE_wxBrushList


// ---------------------------------------------------------------------------
// wxStockGDI

#include "wx/gdicmn.h"

enum wxStockGDI::Item
{
    BRUSH_BLACK,
    BRUSH_BLUE,
    BRUSH_CYAN,
    BRUSH_GREEN,
    BRUSH_GREY,
    BRUSH_LIGHTGREY,
    BRUSH_MEDIUMGREY,
    BRUSH_RED,
    BRUSH_TRANSPARENT,
    BRUSH_WHITE,
    COLOUR_BLACK,
    COLOUR_BLUE,
    COLOUR_CYAN,
    COLOUR_GREEN,
    COLOUR_LIGHTGREY,
    COLOUR_RED,
    COLOUR_WHITE,
    CURSOR_CROSS,
    CURSOR_HOURGLASS,
    CURSOR_STANDARD,
    FONT_ITALIC,
    FONT_NORMAL,
    FONT_SMALL,
    FONT_SWISS,
    PEN_BLACK,
    PEN_BLACKDASHED,
    PEN_CYAN,
    PEN_GREEN,
    PEN_GREY,
    PEN_LIGHTGREY,
    PEN_MEDIUMGREY,
    PEN_RED,
    PEN_TRANSPARENT,
    PEN_WHITE,
    ITEMCOUNT
};

class wxStockGDI
{
    //wxStockGDI() use instance to get the implemented wxStockGDI

    //static void DeleteAll();
    static wxStockGDI& instance();

    static const wxBrush* GetBrush(wxStockGDI::Item item);
    static const wxColour* GetColour(wxStockGDI::Item item);
    static const wxCursor* GetCursor(wxStockGDI::Item item);
    // Can be overridden by platform-specific derived classes
    virtual const wxFont* GetFont(wxStockGDI::Item item);
    static const wxPen* GetPen(wxStockGDI::Item item);
};

#endif //wxLUA_USE_wxColourPenBrush

// ---------------------------------------------------------------------------
// wxPalette

#if wxLUA_USE_wxPalette && wxUSE_PALETTE

#include "wx/palette.h"

class %delete wxPalette : public wxGDIObject
{
    #define_object wxNullPalette
    wxPalette();
    wxPalette(const wxPalette& palette);
    wxPalette(int n, const unsigned char* red, const unsigned char* green, const unsigned char* blue);
    bool Create(int n, const unsigned char* red, const unsigned char* green, const unsigned char* blue); // %override bool wxPalette::Create(int n, Lua string red, Lua string green, Lua string blue);
    int GetColoursCount() const;
    int GetPixel(unsigned char red, unsigned char green, unsigned char blue) const;
    bool IsOk() const;
    wxPalette& operator =(const wxPalette& palette);
    bool GetRGB(int pixel) const; // %override [bool, char red, char green, char blue] wxPalette::GetRGB(int pixel) const;
    bool Ok() const; // %add for compatibility with earlier versions of wxlua
};

#endif //wxLUA_USE_wxPalette && wxUSE_PALETTE

// ---------------------------------------------------------------------------
// wxIcon

#if wxLUA_USE_wxIcon
typedef void* WXHANDLE

class %delete wxIcon : public wxGDIObject
{
    #define_object wxNullIcon
    wxIcon();
    wxIcon(const wxIcon& icon);
    // wxIcon(const char bits[], int width, int height); // doesn't compile on Linux using gcc 4.6-4.8.1
    // wxIcon(const char* const* bits); // wxlua doesn't handle `const char* const*`
    wxIcon(const wxString& name, wxBitmapType type, int desiredWidth = -1, int desiredHeight = -1);
    wxIcon(const wxIconLocation& loc);
    // bool CreateFromHICON(WXHICON icon); // skip this one as it's windows specific
    // wxIcon ConvertToDisabled(unsigned char brightness = 255) const; // skip as it's win-only; can use one from wxBitmap
    void    CopyFromBitmap(const wxBitmap& bmp);
    int     GetDepth();
    int     GetHeight();
    int     GetWidth();
    bool    IsOk() const;
    bool    LoadFile(const wxString& name, wxBitmapType type = wxICON_DEFAULT_TYPE, int desiredWidth = -1, int desiredHeight = -1);
    void    SetDepth(int d);
    void    SetHeight(int h);
    void    SetWidth(int w);
    wxIcon& operator=(const wxIcon& i) const;
    bool    Ok(); // %add for compatibility with earlier versions of wxlua
};

// ---------------------------------------------------------------------------
// wxIconBundle

#include "wx/iconbndl.h"

// Flags that determine what happens if GetIcon() doesn't find the icon of
// exactly the requested size.
enum wxIconBundle::FALLBACK
{
    FALLBACK_NONE,
    FALLBACK_SYSTEM,
    FALLBACK_NEAREST_LARGER
};

class %delete wxIconBundle
{
    wxIconBundle();
    wxIconBundle(const wxString& file, wxBitmapType type = wxBITMAP_TYPE_ANY);
    wxIconBundle(const wxIcon& icon);

    // adds all the icons contained in the file to the collection,
    // if the collection already contains icons with the same
    // width and height, they are replaced
    void AddIcon(const wxString& file, wxBitmapType type = wxBITMAP_TYPE_ANY);
    
    // adds the icon to the collection, if the collection already
    // contains an icon with the same width and height, it is
    // replaced
    void AddIcon(const wxIcon& icon);

    // returns the icon with the given size; if no such icon exists,
    // behavior is specified by the flags.
    wxIcon GetIcon(const wxSize& size, int flags = wxIconBundle::FALLBACK_SYSTEM) const;
    // equivalent to GetIcon(wxSize(size, size));
    wxIcon GetIcon(wxCoord size = wxDefaultCoord, int flags = wxIconBundle::FALLBACK_SYSTEM) const;
    
    // returns the icon exactly of the specified size or wxNullIcon if no icon
    // of exactly given size are available
    wxIcon GetIconOfExactSize(const wxSize& size) const;
    wxIcon GetIconOfExactSize(wxCoord size) const;

    // enumerate all icons in the bundle: don't use these functions if ti can
    // be avoided, using GetIcon() directly is better

    // return the number of available icons
    size_t GetIconCount() const;

    // return the icon at index (must be < GetIconCount())
    wxIcon GetIconByIndex(size_t n) const;

    // check if we have any icons at all
    bool IsEmpty() const;
};

#endif //wxLUA_USE_wxIcon

// ---------------------------------------------------------------------------
// wxBitmap

#if wxLUA_USE_wxBitmap

#include "wx/bitmap.h"

class %delete wxBitmap : public wxGDIObject
{
    #define_object wxNullBitmap
    wxBitmap();
    wxBitmap(const wxBitmap& bitmap);
    wxBitmap(const char bits[], int width, int height, int depth = 1);
    wxBitmap(int width, int height, int depth = -1);
    wxBitmap(const wxSize& sz, int depth = wxBITMAP_SCREEN_DEPTH);
    // wxBitmap(const char* const* bits); // wxlua doesn't handle `const char* const*`
    wxBitmap(const wxString& name, wxBitmapType type = wxBITMAP_TYPE_ANY);
    wxBitmap(const wxImage &image, int depth = -1);
    %win wxBitmap(const wxCursor& cursor); // %override windows only
    // %win static void AddHandler(wxBitmapHandler* handler); // no support for wxBitmapHandler
    // %win static void CleanUpHandlers(); // no support for wxBitmapHandler
    wxImage ConvertToImage();
    bool CopyFromIcon(const wxIcon& icon);
    virtual bool Create(int width, int height, int depth = -1);
    bool Create(const wxSize& sz, int depth = wxBITMAP_SCREEN_DEPTH);
    bool Create(int width, int height, const wxDC& dc);
    bool CreateScaled(int logwidth, int logheight, int depth, double logicalScale);
    // static wxBitmapHandler* FindHandler(const wxString& name); // no support for wxBitmapHandler
    // static wxBitmapHandler* FindHandler(const wxString& extension, wxBitmapType bitmapType); // no support for wxBitmapHandler
    // static wxBitmapHandler* FindHandler(wxBitmapType bitmapType); // no support for wxBitmapHandler
    int GetDepth() const;
    // %win static wxGDIImageHandlerList& GetHandlers(); // no support for wxBitmapHandler
    int GetHeight() const;
    wxMask* GetMask() const;
    wxPalette* GetPalette() const;
    wxBitmap GetSubBitmap(const wxRect&rect) const;
    wxSize GetSize() const;
    wxBitmap ConvertToDisabled(unsigned char brightness = 255) const;
    int GetWidth() const;
    // %win static void InitStandardHandlers(); // no support for wxBitmapHandler
    // %win static void InsertHandler(wxBitmapHandler* handler); // no support for wxBitmapHandler
    bool IsOk() const;
    bool LoadFile(const wxString& name, wxBitmapType type);
    static wxBitmap NewFromPNGData(const void* data, size_t size);
    // %win static bool RemoveHandler(const wxString& name); // no support for wxBitmapHandler
    bool SaveFile(const wxString& name, wxBitmapType type, const wxPalette* palette = NULL) const;
    void SetDepth(int depth);
    void SetHeight(int height);
    void SetMask(%ungc wxMask* mask);
    %win void SetPalette(const wxPalette& palette);
    void SetWidth(int width);
    %override_name wxLua_wxBitmapFromBitTable_constructor wxBitmap(LuaTable charTable, int width, int height, int depth /* = 1 */); // %override wxBitmap(LuaTable charTable, int width, int height, int depth);
    %override_name wxLua_wxBitmapFromBits_constructor wxBitmap(const char* mono_bits, int width, int height, int depth /* = 1 */); // %override wxBitmap(lua string, int width, int height, int depth);
    %override_name wxLua_wxBitmapFromData_constructor %win wxBitmap(const wxString& data, int type, int width, int height, int depth /* = -1 */); // %override wxBitmap(Lua string of data, int type, int width, int height, int depth = -1);
    %override_name wxLua_wxBitmapFromXPMData_constructor wxBitmap(LuaTable charTable); // %override wxBitmap(LuaTable stringTable where each index is a row in the image);
    // !%msw virtual wxColour QuantizeColour(const wxColour& colour) const; // generic implementation only; not present in interface files
    bool Ok() const; // %add for compatibility with earlier versions of wxlua
};

#endif //wxLUA_USE_wxBitmap

// ---------------------------------------------------------------------------
// wxCursor

#if wxLUA_USE_wxCursor

//typedef void* WXHANDLE

#include "wx/cursor.h"

enum wxStockCursor
{
    wxCURSOR_NONE,
    wxCURSOR_ARROW,
    wxCURSOR_RIGHT_ARROW,
    wxCURSOR_BULLSEYE,
    wxCURSOR_CHAR,
    wxCURSOR_CROSS,
    wxCURSOR_HAND,
    wxCURSOR_IBEAM,
    wxCURSOR_LEFT_BUTTON,
    wxCURSOR_MAGNIFIER,
    wxCURSOR_MIDDLE_BUTTON,
    wxCURSOR_NO_ENTRY,
    wxCURSOR_PAINT_BRUSH,
    wxCURSOR_PENCIL,
    wxCURSOR_POINT_LEFT,
    wxCURSOR_POINT_RIGHT,
    wxCURSOR_QUESTION_ARROW,
    wxCURSOR_RIGHT_BUTTON,
    wxCURSOR_SIZENESW,
    wxCURSOR_SIZENS,
    wxCURSOR_SIZENWSE,
    wxCURSOR_SIZEWE,
    wxCURSOR_SIZING,
    wxCURSOR_SPRAYCAN,
    wxCURSOR_WAIT,
    wxCURSOR_WATCH,
    wxCURSOR_BLANK,
    wxCURSOR_DEFAULT,
    %mac wxCURSOR_COPY_ARROW,

    #if defined(__X__);
        // Not yet implemented for Windows
        wxCURSOR_CROSS_REVERSE,
        wxCURSOR_DOUBLE_ARROW,
        wxCURSOR_BASED_ARROW_UP,
        wxCURSOR_BASED_ARROW_DOWN,
    #endif // X11

    wxCURSOR_ARROWWAIT,
    wxCURSOR_MAX
};

class %delete wxCursor : public wxGDIObject
{
    #define_object  wxNullCursor
    %rename wxSTANDARD_CURSOR  #define_pointer wxLua_wxSTANDARD_CURSOR  // hack for wxWidgets >2.7
    %rename wxHOURGLASS_CURSOR #define_pointer wxLua_wxHOURGLASS_CURSOR
    %rename wxCROSS_CURSOR     #define_pointer wxLua_wxCROSS_CURSOR
    wxCursor();
    // wxCursor(const char bits[], int width, int height, int hotSpotX = -1, int hotSpotY = -1, const char maskBits[] = NULL); // doesn't compile in wxlua, so skip it
    wxCursor(const wxString& cursorName, wxBitmapType type, int hotSpotX = 0, int hotSpotY = 0);
    wxCursor(wxStockCursor cursorId);
    wxCursor(const wxImage& image);
    wxCursor(const wxCursor& cursor);
    bool IsOk() const;
    wxPoint GetHotSpot() const;
    wxCursor& operator =(const wxCursor& cursor);
    %win int GetDepth(); // %add only for windows
    %win int GetHeight(); // %add only for windows
    %win int GetWidth(); // %add only for windows
    bool Ok(); // %add for compatibility with earlier versions of wxlua
};

#endif //wxLUA_USE_wxCursor

// ---------------------------------------------------------------------------
// wxMask

#if wxLUA_USE_wxMask

#include "wx/bitmap.h"

class %delete wxMask : public wxObject
{
    wxMask();
    %win wxMask(const wxBitmap& bitmap, int index);
    wxMask(const wxBitmap& bitmap);
    wxMask(const wxBitmap& bitmap, const wxColour& colour);
    %win bool Create(const wxBitmap& bitmap, int index);
    bool Create(const wxBitmap& bitmap);
    bool Create(const wxBitmap& bitmap, const wxColour& colour);
    wxBitmap GetBitmap() const;
};

#endif //wxLUA_USE_wxMask

// ---------------------------------------------------------------------------
// wxImageList

#if wxLUA_USE_wxImageList

#include "wx/imaglist.h"

#define wxIMAGELIST_DRAW_NORMAL
#define wxIMAGELIST_DRAW_TRANSPARENT
#define wxIMAGELIST_DRAW_SELECTED
#define wxIMAGELIST_DRAW_FOCUSED

#define wxIMAGE_LIST_NORMAL
#define wxIMAGE_LIST_SMALL
#define wxIMAGE_LIST_STATE

class %delete wxImageList : public wxObject
{
    wxImageList(int width, int height, bool mask = true, int initialCount = 1);

    int Add(const wxBitmap& bitmap, const wxBitmap& mask = wxNullBitmap);
    int Add(const wxBitmap& bitmap, const wxColour& maskColour);
    int Add(const wxIcon& icon);
    bool    Draw(int index, wxDC& dc, int x, int y, int flags = wxIMAGELIST_DRAW_NORMAL, bool solidBackground = false);
    wxBitmap GetBitmap(int index) const;
    wxIcon  GetIcon(int index) const;
    int     GetImageCount();

    // %override [int width, int height] wxImageList::GetSize(int index);
    // C++ Func: void GetSize(int index, int& width, int& height);
    void    GetSize(int index);

    bool    Remove(int index);
    bool    RemoveAll();
    %win bool Replace(int index, const wxBitmap& bitmap, const wxBitmap& mask = wxNullBitmap);
    %gtk|%mac bool Replace(int index, const wxBitmap& bitmap);
    //bool ReplaceIcon(int index, const wxIcon& icon);
};

#endif //wxLUA_USE_wxImageList

// ---------------------------------------------------------------------------
// wxDC

#if wxLUA_USE_wxDC

#include "wx/dc.h"

enum wxMappingMode
{
    wxMM_TEXT,
    wxMM_METRIC,
    wxMM_LOMETRIC,
    wxMM_TWIPS,
    wxMM_POINTS,
};

enum wxRasterOperationMode
{
    wxCLEAR,       // 0
    wxXOR,         // src XOR dst
    wxINVERT,      // NOT dst
    wxOR_REVERSE,  // src OR (NOT dst)
    wxAND_REVERSE, // src AND (NOT dst)
    wxCOPY,        // src
    wxAND,         // src AND dst
    wxAND_INVERT,  // (NOT src) AND dst
    wxNO_OP,       // dst
    wxNOR,         // (NOT src) AND (NOT dst)
    wxEQUIV,       // (NOT src) XOR dst
    wxSRC_INVERT,  // (NOT src)
    wxOR_INVERT,   // (NOT src) OR dst
    wxNAND,        // (NOT src) OR (NOT dst)
    wxOR,          // src OR dst
    wxSET          // 1
};

enum wxFloodFillStyle
{
    wxFLOOD_BORDER,
    wxFLOOD_SURFACE
};

enum wxPolygonFillMode
{
    wxODDEVEN_RULE,
    wxWINDING_RULE
};

class %delete wxDC : public wxObject
{
    // %win wxDC() wxDC is abstract use wxXXXDC

    //void BeginDrawing(); // these are deprecated in 2.8 and didn't do anything anyway
    bool Blit(wxCoord xdest, wxCoord ydest, wxCoord width, wxCoord height, wxDC* source, wxCoord xsrc, wxCoord ysrc, wxRasterOperationMode logicalFunc = wxCOPY, bool useMask = false);
    void CalcBoundingBox(wxCoord x, wxCoord y);
    void Clear();
    //void ComputeScaleAndOrigin()  used internally
    void CrossHair(wxCoord x, wxCoord y);
    void DestroyClippingRegion();
    wxCoord DeviceToLogicalX(wxCoord x);
    wxCoord DeviceToLogicalXRel(wxCoord x);
    wxCoord DeviceToLogicalY(wxCoord y);
    wxCoord DeviceToLogicalYRel(wxCoord y);
    void DrawArc(wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2, wxCoord xc, wxCoord yc);
    void DrawBitmap(const wxBitmap& bitmap, wxCoord x, wxCoord y, bool transparent);
    void DrawCheckMark(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
    void DrawCheckMark(const wxRect &rect);
    void DrawCircle(wxCoord x, wxCoord y, wxCoord radius);
    //void DrawCircle(const wxPoint& pt, wxCoord radius);
    void DrawEllipse(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
    //void DrawEllipse(const wxPoint& pt, const wxSize& size);
    //void DrawEllipse(const wxRect& rect);
    void DrawEllipticArc(wxCoord x, wxCoord y, wxCoord width, wxCoord height, double start, double end);
    void DrawIcon(const wxIcon& icon, wxCoord x, wxCoord y);
    void DrawLabel(const wxString& text, const wxBitmap& image, const wxRect& rect, int alignment = wxALIGN_LEFT | wxALIGN_TOP, int indexAccel = -1); //, wxRect *rectBounding = NULL);
    void DrawLabel(const wxString& text, const wxRect& rect, int alignment = wxALIGN_LEFT | wxALIGN_TOP, int indexAccel = -1);
    void DrawLine(wxCoord x1, wxCoord y1, wxCoord x2, wxCoord y2);

    //void DrawLines(int n, wxPoint points[], wxCoord xoffset = 0, wxCoord yoffset = 0);
    // Provide a Lua Table of {{1,2},{3,4},...}, {{x=1,y=2},{x=3,y=4},...}, or {wx.wxPoint(1,2),wx.wxPoint(3,4),...}
    void DrawLines(wxPointArray_FromLuaTable points, wxCoord xoffset = 0, wxCoord yoffset = 0);
    //void DrawLines(const wxPointList *points, wxCoord xoffset = 0, wxCoord yoffset = 0);

    //void DrawPolygon(int n, wxPoint points[], wxCoord xoffset = 0, wxCoord yoffset = 0, wxPolygonFillMode fill_style = wxODDEVEN_RULE);
    // Provide a Lua Table of {{1,2},{3,4},...}, {{x=1,y=2},{x=3,y=4},...}, or {wx.wxPoint(1,2),wx.wxPoint(3,4),...}
    void DrawPolygon(wxPointArray_FromLuaTable points, wxCoord xoffset = 0, wxCoord yoffset = 0, wxPolygonFillMode fill_style = wxODDEVEN_RULE);
    //void DrawPolygon(const wxPointList *points, wxCoord xoffset = 0, wxCoord yoffset = 0, wxPolygonFillMode fill_style = wxODDEVEN_RULE);

    //void DrawPolyPolygon(int n, int count[], wxPoint points[], wxCoord xoffset = 0, wxCoord yoffset = 0, wxPolygonFillMode fill_style = wxODDEVEN_RULE);

    void DrawPoint(wxCoord x, wxCoord y);
    void DrawRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
    void DrawRotatedText(const wxString& text, wxCoord x, wxCoord y, double angle);
    void DrawRoundedRectangle(wxCoord x, wxCoord y, wxCoord width, wxCoord height, double radius = 20);
    #if wxUSE_SPLINES
        //void DrawSpline(int n, wxPoint points[]);
        // Provide a Lua Table of {{1,2},{3,4},...}, {{x=1,y=2},{x=3,y=4},...}, or {wx.wxPoint(1,2),wx.wxPoint(3,4),...}
        void DrawSpline(wxPointArray_FromLuaTable points);
        //void DrawSpline(wxObjectList *points);
    #endif //wxUSE_SPLINES
    void DrawText(const wxString& text, wxCoord x, wxCoord y);
    void EndDoc();
    //void EndDrawing();  // these are deprecated in 2.8 and didn't do anything anyway
    void EndPage();
    void FloodFill(wxCoord x, wxCoord y, const wxColour& colour, wxFloodFillStyle style=wxFLOOD_SURFACE);

    //void GradientFillConcentric(const wxRect& rect, const wxColour& initialColour, const wxColour& destColour);
    void GradientFillConcentric(const wxRect& rect, const wxColour& initialColour, const wxColour& destColour, const wxPoint& circleCenter);
    void GradientFillLinear(const wxRect& rect, const wxColour& initialColour, const wxColour& destColour, wxDirection nDirection = wxEAST);
    wxBitmap GetAsBitmap(const wxRect *subrect = NULL) const;

    // alias
    const wxBrush& GetBackground();
    int GetBackgroundMode() const;
    const wxBrush& GetBrush();
    wxCoord GetCharHeight();
    wxCoord GetCharWidth();
    void GetClippingBox(wxCoord *x, wxCoord *y, wxCoord *width, wxCoord *height);
    const wxFont& GetFont();
    wxLayoutDirection GetLayoutDirection() const;
    int GetLogicalFunction();
    int GetMapMode();
    //bool GetPartialTextExtents(const wxString& text, wxArrayInt& widths) const;
    const wxPen& GetPen();
    bool GetPixel(wxCoord x, wxCoord y, wxColour *colour);
    wxSize GetPPI() const;
    void GetSize(wxCoord *width, wxCoord *height); // wxSize GetSize() const;
    //void GetSizeMM(wxCoord *width, wxCoord *height) const; // wxSize GetSizeMM() const;
    const wxColour& GetTextBackground() const;

    // %override [int x, int y, int descent, int externalLeading] int wxDC::GetTextExtent(const wxString& string, const wxFont* font = NULL);
    // C++ Func: void GetTextExtent(const wxString& string, wxCoord* x, wxCoord* y, wxCoord* descent = NULL, wxCoord* externalLeading = NULL, const wxFont* font = NULL);
    void GetTextExtent(const wxString& string, wxFont *font = NULL);

    %rename GetTextExtentSize wxSize GetTextExtent(const wxString& string) const;

    // %override [int x, int y, int heightLine] int wxDC::GetMultiLineTextExtent(const wxString& string, const wxFont* font = NULL);
    // C++ Func: void GetMultiLineTextExtent(const wxString& string, wxCoord* x, wxCoord* y, wxCoord* heightLine = NULL, const wxFont* font = NULL);
    void GetMultiLineTextExtent(const wxString& string, wxFont *font = NULL) const;

    %rename GetMultiLineTextExtentSize wxSize GetMultiLineTextExtent(const wxString& string) const;

    const wxColour& GetTextForeground();

    // %override [int x, int y] wxDC::GetUserScale();
    // C++ Func: void GetUserScale(double *x, double *y);
    void GetUserScale();

    wxCoord LogicalToDeviceX(wxCoord x);
    wxCoord LogicalToDeviceXRel(wxCoord x);
    wxCoord LogicalToDeviceY(wxCoord y);
    wxCoord LogicalToDeviceYRel(wxCoord y);
    wxCoord MaxX();
    wxCoord MaxY();
    wxCoord MinX();
    wxCoord MinY();
    bool IsOk();
    void ResetBoundingBox();
    void SetAxisOrientation(bool xLeftRight, bool yBottomUp);
    virtual double GetContentScaleFactor() const;
    void SetBackground(const wxBrush& brush);
    void SetBackgroundMode(int mode);
    void SetBrush(const wxBrush& brush);
    void SetClippingRegion(wxCoord x, wxCoord y, wxCoord width, wxCoord height);
    void SetClippingRegion(const wxRegion& region);
    //void SetClippingRegion(const wxPoint& pt, const wxSize& sz);
    //void SetClippingRegion(const wxRect& rect);
    void SetDeviceOrigin(wxCoord x, wxCoord y);
    void SetFont(const wxFont& font);
    void SetLayoutDirection(wxLayoutDirection dir);
    void SetLogicalFunction(wxRasterOperationMode function);
    void SetMapMode(wxMappingMode unit);
    void SetPalette(const wxPalette& palette);
    void SetPen(const wxPen& pen);
    void SetTextBackground(const wxColour& colour);
    void SetTextForeground(const wxColour& colour);
    void SetUserScale(double xScale, double yScale);
    bool StartDoc(const wxString& message);
    void StartPage();
};

// ---------------------------------------------------------------------------
// wxMemoryDC

#include "wx/dcmemory.h"

class %delete wxMemoryDC : public wxDC
{
    wxMemoryDC();
    void SelectObject(wxBitmap& bitmap); // not const in >=2.8

    virtual void SelectObjectAsSource(const wxBitmap& bmp);
};

// ---------------------------------------------------------------------------
// wxWindowDC

#include "wx/dcclient.h"

class %delete wxWindowDC : public wxDC
{
    wxWindowDC(wxWindow* window);
};

// ---------------------------------------------------------------------------
// wxClientDC

#include "wx/dcclient.h"

class %delete wxClientDC : public wxWindowDC
{
    wxClientDC(wxWindow* window);
};

// ---------------------------------------------------------------------------
// wxPaintDC

#include "wx/dcclient.h"

class %delete wxPaintDC : public wxWindowDC // base ok as wxWindowDC since only some platforms have wxClientDC as base
{
    wxPaintDC(wxWindow* window);
};

// ---------------------------------------------------------------------------
// wxScreenDC

#include "wx/dcscreen.h"

class %delete wxScreenDC : public wxDC
{
    wxScreenDC();

    static bool StartDrawingOnTop(wxWindow* window);
    static bool StartDrawingOnTop(wxRect* rect = NULL);
    static bool EndDrawingOnTop();
};

// ---------------------------------------------------------------------------
// wxBufferedDC

#include "wx/dcbuffer.h"

class %delete wxBufferedDC : public wxMemoryDC
{
    wxBufferedDC();
    wxBufferedDC(wxDC *dc, const wxSize& area, int style = wxBUFFER_CLIENT_AREA);
    wxBufferedDC(wxDC *dc, wxBitmap& buffer, int style = wxBUFFER_CLIENT_AREA); // not const bitmap >= 2.8

    void Init(wxDC *dc, const wxSize& area, int style = wxBUFFER_CLIENT_AREA);
    void Init(wxDC *dc, wxBitmap& buffer, int style = wxBUFFER_CLIENT_AREA); // not const bitmap in >= 2.8
};

// ---------------------------------------------------------------------------
// wxBufferedPaintDC

#include "wx/dcbuffer.h"

class %delete wxBufferedPaintDC : public wxBufferedDC
{
    wxBufferedPaintDC(wxWindow *window, int style = wxBUFFER_CLIENT_AREA);
    wxBufferedPaintDC(wxWindow *window, wxBitmap& buffer, int style = wxBUFFER_CLIENT_AREA); // not const bitmap in >= 2.8
};

// ---------------------------------------------------------------------------
// wxAutoBufferedPaintDC

#include "wx/dcbuffer.h"

#define wxALWAYS_NATIVE_DOUBLE_BUFFER

// This class is derived from a wxPaintDC if wxALWAYS_NATIVE_DOUBLE_BUFFER else wxBufferedPaintDC
// In fact in release mode it's only a #define to either

class %delete wxAutoBufferedPaintDC : public wxDC // base ok as wxDC since no need for others
{
    wxAutoBufferedPaintDC(wxWindow *window);
};

// ---------------------------------------------------------------------------
// wxMirrorDC

#include "wx/dcmirror.h"

class %delete wxMirrorDC : public wxDC
{
    wxMirrorDC(wxDC& dc, bool mirror);
};

// ---------------------------------------------------------------------------
// wxDCClipper

#include "wx/dc.h"

class %delete wxDCClipper
{
    wxDCClipper(wxDC& dc, const wxRect& r);
    //wxDCClipper(wxDC& dc, const wxRegion& r);
    wxDCClipper(wxDC& dc, wxCoord x, wxCoord y, wxCoord w, wxCoord h);
};

#endif //wxLUA_USE_wxDC

// ---------------------------------------------------------------------------
// wxCaret

#if wxLUA_USE_wxCaret && wxUSE_CARET

#include "wx/caret.h"

class %delete wxCaret
{
    wxCaret();
    wxCaret(wxWindow* window, int width, int height);
    wxCaret(wxWindow* window, const wxSize& size);
    bool Create(wxWindow* window, int width, int height);
    bool Create(wxWindow* window, const wxSize& size);
    static int GetBlinkTime();
    wxPoint GetPosition();
    wxSize GetSize();
    wxWindow *GetWindow();
    void Hide();
    bool IsOk();
    bool IsVisible();
    void Move(int x, int y);
    void Move(const wxPoint& pt);
    static void SetBlinkTime(int ms);
    void SetSize(int width, int height);
    void SetSize(const wxSize& size);
    void Show(bool show = true);
    %rename GetPositionXY void GetPosition(); // %override [int x, int y] wxCaret::GetPositionXY();
    %rename GetSizeWH void GetSize(); // %override [int x, int y] wxCaret::GetSizeWH();
};

// ---------------------------------------------------------------------------
// wxCaretSuspend

#include "wx/caret.h"

class %delete wxCaretSuspend
{
    // NOTE: ALWAYS delete() this when done since Lua's gc may not delete it soon enough
    wxCaretSuspend(wxWindow *win = NULL);
};

#endif //wxLUA_USE_wxCaret && wxUSE_CARET

// ---------------------------------------------------------------------------
// wxVideoMode

#if wxLUA_USE_wxDisplay && wxUSE_DISPLAY

#include "wx/display.h"

class %delete wxVideoMode
{
    #define_object wxDefaultVideoMode

    wxVideoMode(int width = 0, int height = 0, int depth = 0, int freq = 0);

    bool Matches(const wxVideoMode& other) const;
    int  GetWidth() const;
    int  GetHeight() const;
    int  GetDepth() const;
    bool IsOk() const;

    bool operator==(const wxVideoMode& v) const;
};

// ---------------------------------------------------------------------------
// wxArrayVideoModes

class %delete wxArrayVideoModes
{
    wxArrayVideoModes();
    wxArrayVideoModes(const wxArrayVideoModes& array);

    void Add(const wxVideoMode& vm, size_t copies = 1);
    void Alloc(size_t nCount);
    void Clear();
    void Empty();
    int  GetCount() const;
    void Insert(const wxVideoMode& vm, int nIndex, size_t copies = 1);
    bool IsEmpty();
    wxVideoMode Item(size_t nIndex) const;
    wxVideoMode Last();
    void RemoveAt(size_t nIndex, size_t count = 1);
    void Shrink();

    wxVideoMode& operator[](size_t nIndex);
};

// ---------------------------------------------------------------------------
// wxDisplay

class %delete wxDisplay
{
    wxDisplay(unsigned int index = 0);
    bool  ChangeMode(const wxVideoMode& mode = wxDefaultVideoMode);
    wxRect GetClientArea() const;
    static size_t GetCount();
    wxVideoMode  GetCurrentMode() const;
    static int GetFromPoint(const wxPoint& pt);
    wxRect  GetGeometry() const;
    wxArrayVideoModes  GetModes(const wxVideoMode& mode = wxDefaultVideoMode) const;
    wxString  GetName() const;
    bool  IsPrimary();
    static int GetFromWindow(wxWindow* win);
};

#endif //wxLUA_USE_wxDisplay && wxUSE_DISPLAY

// ---------------------------------------------------------------------------
// wxRenderer

#if wxLUA_USE_wxRenderer

#include "wx/renderer.h"

%wxHAS_NATIVE_RENDERER #define wxHAS_NATIVE_RENDERER 1

enum
{
    wxCONTROL_DISABLED,   //= 0x00000001,  // control is disabled
    wxCONTROL_FOCUSED,    //= 0x00000002,  // currently has keyboard focus
    wxCONTROL_PRESSED,    //= 0x00000004,  // (button) is pressed
    wxCONTROL_SPECIAL,    //= 0x00000008,  // control-specific bit:
    wxCONTROL_ISDEFAULT,  //= wxCONTROL_SPECIAL, // only for the buttons
    wxCONTROL_ISSUBMENU,  //= wxCONTROL_SPECIAL, // only for the menu items
    wxCONTROL_EXPANDED,   //= wxCONTROL_SPECIAL, // only for the tree items
    wxCONTROL_SIZEGRIP,   //= wxCONTROL_SPECIAL, // only for the status bar panes
    wxCONTROL_CURRENT,    //= 0x00000010,  // mouse is currently over the control
    wxCONTROL_SELECTED,   //= 0x00000020,  // selected item in e.g. listbox
    wxCONTROL_CHECKED,    //= 0x00000040,  // (check/radio button) is checked
    wxCONTROL_CHECKABLE,  //= 0x00000080,  // (menu) item can be checked
    wxCONTROL_UNDETERMINED, //= wxCONTROL_CHECKABLE, // (check) undetermined state

    wxCONTROL_FLAGS_MASK, //= 0x000000ff,

    // this is a pseudo flag not used directly by wxRenderer but rather by some
    // controls internally
    wxCONTROL_DIRTY       //= 0x80000000
};

struct %delete wxSplitterRenderParams
{
    // the only way to initialize this struct is by using this ctor
    wxSplitterRenderParams(wxCoord widthSash_, wxCoord border_, bool isSens_);

    const wxCoord widthSash;     // the width of the splitter sash
    const wxCoord border;        // the width of the border of the splitter window
    const bool isHotSensitive;   // true if the splitter changes its appearance when the mouse is over it
};


// extra optional parameters for DrawHeaderButton
struct %delete wxHeaderButtonParams
{
    wxHeaderButtonParams();

    wxColour    m_arrowColour;
    wxColour    m_selectionColour;
    wxString    m_labelText;
    wxFont      m_labelFont;
    wxColour    m_labelColour;
    wxBitmap    m_labelBitmap;
    int         m_labelAlignment;
};

enum wxHeaderSortIconType
{
    wxHDR_SORT_ICON_NONE,        // Header button has no sort arrow
    wxHDR_SORT_ICON_UP,          // Header button an an up sort arrow icon
    wxHDR_SORT_ICON_DOWN         // Header button an a down sort arrow icon
};

// the current version and age of wxRendererNative interface: different
// versions are incompatible (in both ways) while the ages inside the same
// version are upwards compatible, i.e. the version of the renderer must
// match the version of the main program exactly while the age may be
// highergreater or equal to it
enum wxRendererVersion::dummy
{
    Current_Version, //= 1,
    Current_Age      //= 5
};

// wxRendererNative interface version
struct %delete wxRendererVersion
{
    wxRendererVersion(int version_, int age_);

    // check if the given version is compatible with the current one
    static bool IsCompatible(const wxRendererVersion& ver);

    const int version;
    const int age;
};


class %delete wxRendererNative
{
    // pseudo constructors
    // -------------------
    // return the currently used renderer
    static wxRendererNative& Get();
    // return the generic implementation of the renderer
    static wxRendererNative& GetGeneric();
    // return the default (native) implementation for this platform
    static wxRendererNative& GetDefault();


    // draw the header control button (used by wxListCtrl) Returns optimal
    // width for the label contents.
    virtual int  DrawHeaderButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0, wxHeaderSortIconType sortArrow = wxHDR_SORT_ICON_NONE, wxHeaderButtonParams* params=NULL); //= 0;

    // Draw the contents of a header control button (label, sort arrows, etc.);
    // Normally only called by DrawHeaderButton.
    virtual int  DrawHeaderButtonContents(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0, wxHeaderSortIconType sortArrow = wxHDR_SORT_ICON_NONE, wxHeaderButtonParams* params=NULL); //= 0;

    // Returns the default height of a header button, either a fixed platform
    // height if available, or a generic height based on the window's font.
    virtual int GetHeaderButtonHeight(wxWindow *win); //= 0;

    // draw the expanded/collapsed icon for a tree control item
    virtual void DrawTreeItemButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // draw the border for sash window: this border must be such that the sash
    // drawn by DrawSash() blends into it well
    virtual void DrawSplitterBorder(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // draw a (vertical) sash
    virtual void DrawSplitterSash(wxWindow *win, wxDC& dc, const wxSize& size, wxCoord position, wxOrientation orient, int flags = 0); //= 0;

    // draw a combobox dropdown button
    // flags may use wxCONTROL_PRESSED and wxCONTROL_CURRENT
    virtual void DrawComboBoxDropButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // draw a dropdown arrow
    // flags may use wxCONTROL_PRESSED and wxCONTROL_CURRENT
    virtual void DrawDropArrow(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // draw check button
    // flags may use wxCONTROL_CHECKED, wxCONTROL_UNDETERMINED and wxCONTROL_CURRENT
    virtual void DrawCheckBox(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // draw blank button
    // flags may use wxCONTROL_PRESSED, wxCONTROL_CURRENT and wxCONTROL_ISDEFAULT
    virtual void DrawPushButton(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // draw rectangle indicating that an item in e.g. a list control has been selected or focused
    // flags may use
    // wxCONTROL_SELECTED (item is selected, e.g. draw background);
    // wxCONTROL_CURRENT (item is the current item, e.g. dotted border);
    // wxCONTROL_FOCUSED (the whole control has focus, e.g. blue background vs. grey otherwise);
    virtual void DrawItemSelectionRect(wxWindow *win, wxDC& dc, const wxRect& rect, int flags = 0); //= 0;

    // geometry functions
    // ------------------

    // get the splitter parameters: the x field of the returned point is the
    // sash width and the y field is the border width
    virtual wxSplitterRenderParams GetSplitterParams(const wxWindow *win); //= 0;

    // changing the global renderer
    // ----------------------------

#if wxUSE_DYNLIB_CLASS
    // load the renderer from the specified DLL, the returned pointer must be
    // deleted by caller if not NULL when it is not used any more
    static %gc wxRendererNative *Load(const wxString& name);
#endif // wxUSE_DYNLIB_CLASS

    // set the renderer to use, passing NULL reverts to using the default
    // renderer
    //
    // return the previous renderer used with Set() or NULL if none
    static %gc wxRendererNative *Set(%ungc wxRendererNative *renderer);

    // this function is used for version checking: Load() refuses to load any
    // DLLs implementing an older or incompatible version; it should be
    // implemented simply by returning wxRendererVersion::Current_XXX values
    virtual wxRendererVersion GetVersion() const; //= 0;
};

#endif // wxLUA_USE_wxRenderer
