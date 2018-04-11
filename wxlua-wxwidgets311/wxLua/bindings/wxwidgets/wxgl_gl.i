// ===========================================================================
// Purpose:     wxGL library
// Author:      J Winwood, John Labenski
// Created:     14/11/2001
// Copyright:   (c) 2001-2002 Lomtick Software. All rights reserved.
// Licence:     wxWidgets licence
// wxWidgets:   Updated to 2.8.4
// ===========================================================================

//#if wxUSE_OPENGL // FIXME ? Is it probably enough to test for wxUSE_GLCANVAS

// ---------------------------------------------------------------------------
// wxGLCanvas

#if wxLUA_USE_wxGLCanvas && wxUSE_GLCANVAS

// FIXME : Need to wrap wxGLApp?

#include "wx/glcanvas.h"

enum
{
    WX_GL_RGBA,
    WX_GL_BUFFER_SIZE,
    WX_GL_LEVEL,
    WX_GL_DOUBLEBUFFER,
    WX_GL_STEREO,
    WX_GL_AUX_BUFFERS,
    WX_GL_MIN_RED,
    WX_GL_MIN_GREEN,
    WX_GL_MIN_BLUE,
    WX_GL_MIN_ALPHA,
    WX_GL_DEPTH_SIZE,
    WX_GL_STENCIL_SIZE,
    WX_GL_MIN_ACCUM_RED,
    WX_GL_MIN_ACCUM_GREEN,
    WX_GL_MIN_ACCUM_BLUE,
    WX_GL_MIN_ACCUM_ALPHA
};

class wxGLCanvas : public wxWindow
{
    !%mac wxGLCanvas(wxWindow* parent, wxWindowID id = wxID_ANY, int attribList[] = 0, const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxDefaultSize, long style=0, const wxString& name="GLCanvas", const wxPalette& palette = wxNullPalette );

    //wxGLContext* GetContext() const; - removed in wx 3.0
    %mac void SetCurrent( );
    !%mac void SetCurrent(const wxGLContext& RC) const;

    void SetColour(const wxString& colour );
    void SwapBuffers( );
};

// ---------------------------------------------------------------------------
// wxGLContext

class wxGLContext : public wxObject
{
    !%mac wxGLContext(wxGLCanvas *win, const wxGLContext* other = NULL ); // FIXME

    void SetCurrent(const wxGLCanvas& win) const;
};

#endif //wxLUA_USE_wxGLCanvas && wxUSE_GLCANVAS

//#endif wxUSE_OPENGL
