// ----------------------------------------------------------------------------
// Overridden functions for the wxWidgets binding for wxLua
//
// Please keep these functions in the same order as the .i file and in the
// same order as the listing of the functions in that file.
// ----------------------------------------------------------------------------

// ----------------------------------------------------------------------------
// Overrides for wxstc_stc.i
// ----------------------------------------------------------------------------

%override wxLua_wxStyledTextCtrl_GetCurLine
// wxString GetCurLine(int* linePos=NULL)
static int LUACALL wxLua_wxStyledTextCtrl_GetCurLine(lua_State *L)
{
    int linePos;
    // get this
    wxStyledTextCtrl *self = (wxStyledTextCtrl *)wxluaT_getuserdatatype(L, 1, wxluatype_wxStyledTextCtrl);
    // call GetCurLine
    wxString returns = self->GetCurLine(&linePos);
    // push the result string
    lua_pushstring(L, wx2lua(returns));
    lua_pushnumber(L, linePos);
    // return the number of parameters
    return 2;
}
%end

%override wxLua_wxStyledTextCtrl_SetStyleBytes
// void    SetStyleBytes(int length, const wxString &styleBytes)
static int LUACALL wxLua_wxStyledTextCtrl_SetStyleBytes(lua_State *L)
{
    // const wxString &styleBytes
    char* styleBytes = (char*)lua_tostring(L, 3);
    // int length
    int length = (int)lua_tonumber(L, 2);
    // get this
    wxStyledTextCtrl *self = (wxStyledTextCtrl *)wxluaT_getuserdatatype(L, 1, wxluatype_wxStyledTextCtrl);
    // call SetStyleBytes
    self->SetStyleBytes(length, styleBytes);
    // return the number of parameters
    return 0;
}
%end

%override wxLua_wxStyledTextCtrl_PrivateLexerCall
static int LUACALL wxLua_wxStyledTextCtrl_PrivateLexerCall(lua_State *L)
{
    // void pointer
    // check if the parameter is a string; if not, assume it's userdata
    void * pointer = (void *)lua_tostring(L, 3);
    if (pointer == NULL) pointer = (void *)wxlua_touserdata(L, 3);
    // int operation
    int operation = (int)wxlua_getnumbertype(L, 2);
    // get this
    wxStyledTextCtrl * self = (wxStyledTextCtrl *)wxluaT_getuserdatatype(L, 1, wxluatype_wxStyledTextCtrl);
    // call PrivateLexerCall
    void* returns = (void*)self->PrivateLexerCall(operation, pointer);
    // push the result pointer
    lua_pushlightuserdata(L, (void *)returns);

    return 1;
}
%end

%override wxLua_wxStyledTextCtrl_GetSelection
// void virtual void GetSelection(long *from, long *to) const
static int LUACALL wxLua_wxStyledTextCtrl_GetSelection(lua_State *L)
{
    int endPos;
    int startPos;
    // get this
    wxStyledTextCtrl *self = (wxStyledTextCtrl *)wxluaT_getuserdatatype(L, 1, wxluatype_wxStyledTextCtrl);
    // call GetSelection
    self->GetSelection(&startPos, &endPos);
    // push results
    lua_pushnumber(L, startPos);
    lua_pushnumber(L, endPos);
    // return the number of parameters
    return 2;
}
%end
