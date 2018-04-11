// ===========================================================================
// Purpose:     wxXML library
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

#if wxLUA_USE_wxXML && wxUSE_XML

#include "wx/xml/xml.h"

// Represents XML node type.
enum wxXmlNodeType
{
    // note: values are synchronized with xmlElementType from libxml
    wxXML_ELEMENT_NODE,
    wxXML_ATTRIBUTE_NODE,
    wxXML_TEXT_NODE,
    wxXML_CDATA_SECTION_NODE,
    wxXML_ENTITY_REF_NODE,
    wxXML_ENTITY_NODE,
    wxXML_PI_NODE,
    wxXML_COMMENT_NODE,
    wxXML_DOCUMENT_NODE,
    wxXML_DOCUMENT_TYPE_NODE,
    wxXML_DOCUMENT_FRAG_NODE,
    wxXML_NOTATION_NODE,
    wxXML_HTML_DOCUMENT_NODE
};

// Represents node property(ies).
// Example: in <img src="hello.gif" id="3"/> "src" is property with value
//          "hello.gif" and "id" is prop. with value "3".

class %delete wxXmlAttribute
{
    wxXmlAttribute();
    wxXmlAttribute(const wxString& name, const wxString& value, wxXmlAttribute *next = NULL);

    const wxString& GetName() const;
    const wxString& GetValue() const;
    wxXmlAttribute *GetNext() const;

    void SetName(const wxString& name);
    void SetValue(const wxString& value);
    void SetNext(wxXmlAttribute *next);
};

// ---------------------------------------------------------------------------
// wxXmlNode

class %delete wxXmlNode
{
    wxXmlNode();
    
    // %override wxXmlNode::wxXmlNode(wxXmlNode *parent, wxXmlNodeType type, const wxString& name, const wxString& content, wxXmlAttribute *attrs, wxXmlNode *next, int lineNo);
    // C++ Func: No change: if parent is not NULL, created node is not garbage collected.
    wxXmlNode(wxXmlNode *parent, wxXmlNodeType type, const wxString& name, const wxString& content = wxEmptyString, wxXmlAttribute *attrs = NULL, wxXmlNode *next = NULL, int lineNo = -1);

    // user-friendly creation:
    wxXmlNode(wxXmlNodeType type, const wxString& name, const wxString& content = wxEmptyString, int lineNo = -1);
    
    virtual void AddChild(%ungc wxXmlNode *child);
    virtual bool InsertChild(%ungc wxXmlNode *child, wxXmlNode *followingNode);
    virtual bool InsertChildAfter(%ungc wxXmlNode *child, wxXmlNode *precedingNode);
    
    // %override bool wxXmlNode::RemoveChild(%gc wxXmlNode *child);
    // C++ Func: No change: only if child is removed will we garbage collect it
    virtual bool RemoveChild(%gc wxXmlNode *child);
    
    virtual void AddAttribute(const wxString& name, const wxString& value);
    virtual bool DeleteAttribute(const wxString& name);

    // access methods:
    wxXmlNodeType GetType() const;
    const wxString& GetName() const;
    const wxString& GetContent() const;

    bool IsWhitespaceOnly() const;
    int GetDepth(wxXmlNode *grandparent = NULL) const;

    // Gets node content from wxXML_ENTITY_NODE
    // The problem is, <tag>content<tag> is represented as
    // wxXML_ENTITY_NODE name="tag", content=""
    //    |-- wxXML_TEXT_NODE or
    //        wxXML_CDATA_SECTION_NODE name="" content="content"
    wxString GetNodeContent() const;

    wxXmlNode *GetParent() const;
    wxXmlNode *GetNext() const;
    wxXmlNode *GetChildren() const;

    wxXmlAttribute *GetAttributes() const;
    
    // %override [bool string] wxXmlNode::GetAttributePtr(const wxString& attrName) const;
    // C++ Func: bool GetAttribute(const wxString& attrName, wxString *value) const;
    %override_name wxLua_wxXmlNode_GetAttributePtr bool GetAttribute(const wxString& attrName) const;
    
    //wxString GetAttribute(const wxString& attrName, const wxString& defaultVal = wxEmptyString) const;
    bool HasAttribute(const wxString& attrName) const;

    int GetLineNumber() const;

    void SetType(wxXmlNodeType type);
    void SetName(const wxString& name);
    void SetContent(const wxString& con);

    void SetParent(wxXmlNode *parent);
    void SetNext(wxXmlNode *next);
    void SetChildren(%ungc wxXmlNode *child);

    void SetAttributes(%ungc wxXmlAttribute *attr);
    virtual void AddAttribute(%ungc wxXmlAttribute *attr);

    // If true, don't do encoding conversion to improve efficiency - node content is ACII text
    bool GetNoConversion() const;
    void SetNoConversion(bool noconversion);
};

class wxXmlDoctype
{
    wxXmlDoctype(const wxString& name = wxEmptyString, const wxString& sysid = wxEmptyString, const wxString& pubid = wxEmptyString);

    // Default copy ctor and assignment operators are ok.

    bool IsValid() const;
    void Clear();

    const wxString& GetRootName() const;
    const wxString& GetSystemId() const;
    const wxString& GetPublicId() const;

    wxString GetFullString() const;
};

// special indentation value for wxXmlDocument::Save
#define wxXML_NO_INDENTATION

// flags for wxXmlDocument::Load
enum wxXmlDocumentLoadFlag
{
    wxXMLDOC_NONE,
    wxXMLDOC_KEEP_WHITESPACE_NODES
};

#include "wx/textbuf.h"

// ----------------------------------------------------------------------------
// constants
// ----------------------------------------------------------------------------

// the line termination type (kept wxTextFileType name for compatibility)
enum wxTextFileType
{
    wxTextFileType_None,  // incomplete (the last line of the file only)
    wxTextFileType_Unix,  // line is terminated with 'LF' = 0xA = 10 = '\n'
    wxTextFileType_Dos,   //                         'CR' 'LF'
    wxTextFileType_Mac,   //                         'CR' = 0xD = 13 = '\r'
    wxTextFileType_Os2    //                         'CR' 'LF'
};

// ---------------------------------------------------------------------------
// wxXmlDocument

class %delete wxXmlDocument : public wxObject
{
    wxXmlDocument();
    wxXmlDocument(const wxString& filename, const wxString& encoding = "UTF-8");
    //wxXmlDocument(wxInputStream& stream, const wxString& encoding = "UTF-8");

    // Parses .xml file and loads data. Returns TRUE on success, FALSE
    // otherwise.
    virtual bool Load(const wxString& filename, const wxString& encoding = "UTF-8", int flags = wxXMLDOC_NONE);
    //virtual bool Load(wxInputStream& stream, const wxString& encoding = "UTF-8", int flags = wxXMLDOC_NONE);

    // Saves document as .xml file.
    virtual bool Save(const wxString& filename, int indentstep = 2) const;
    //virtual bool Save(wxOutputStream& stream, int indentstep = 2) const;

    bool IsOk() const;

    // Returns root node of the document.
    wxXmlNode *GetRoot() const;
    // Returns the document node.
    wxXmlNode *GetDocumentNode() const;


    // Returns version of document (may be empty).
    const wxString& GetVersion() const;
    // Returns encoding of document (may be empty).
    // Note: this is the encoding original file was saved in, *not* the
    // encoding of in-memory representation!
    const wxString& GetFileEncoding() const;
    const wxXmlDoctype& GetDoctype() const;
    // Returns file type of document
    wxTextFileType GetFileType() const;
    wxString GetEOL() const;

    // Write-access methods:
    wxXmlNode *DetachDocumentNode();
    void SetDocumentNode(wxXmlNode *node);
    wxXmlNode *DetachRoot();
    void SetRoot(%ungc wxXmlNode *node);
    void SetVersion(const wxString& version);
    void SetFileEncoding(const wxString& encoding);
    void SetDoctype(const wxXmlDoctype& doctype);
    void SetFileType(wxTextFileType fileType);
    void AppendToProlog(wxXmlNode *node);

    // These two are not for unicode
#if !wxUSE_UNICODE
    // Returns encoding of in-memory representation of the document
    // (same as passed to Load or ctor, defaults to UTF-8).
    // NB: this is meaningless in Unicode build where data are stored as wchar_t*
    wxString GetEncoding() const;
    void SetEncoding(const wxString& enc);
#endif

    //static wxVersionInfo GetLibraryVersionInfo();
};

#endif //wxLUA_USE_wxXML && wxUSE_XML
