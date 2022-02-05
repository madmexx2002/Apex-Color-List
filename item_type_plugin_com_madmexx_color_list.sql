prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_200100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2020.03.31'
,p_release=>'20.1.0.00.13'
,p_default_workspace_id=>202800322497809042
,p_default_application_id=>130
,p_default_id_offset=>0
,p_default_owner=>'DEVELOPER_APP'
);
end;
/
 
prompt APPLICATION 130 - Sample Application
--
-- Application Export:
--   Application:     130
--   Name:            Sample Application
--   Date and Time:   18:26 Saturday February 5, 2022
--   Exported By:     WSADMIN
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 395601626889294456
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     600155217090744
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/com_madmexx_color_list
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(395601626889294456)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.MADMEXX.COLOR_LIST'
,p_display_name=>'Color List'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'procedure RENDER_COLOR_LIST (',
'    P_ITEM    in  APEX_PLUGIN.T_ITEM',
'  , P_PLUGIN  in  APEX_PLUGIN.T_PLUGIN',
'  , P_PARAM   in  APEX_PLUGIN.T_ITEM_RENDER_PARAM',
'  , P_RESULT  in out nocopy APEX_PLUGIN.T_ITEM_RENDER_RESULT',
') is ',
'',
'    L_COLOR_MODIFIER  varchar2(16) := case when P_ITEM.ATTRIBUTE_02 in (''Block'',''-border'') then null else P_ITEM.ATTRIBUTE_02 end; ',
'    L_COLOR_TEXT      varchar2(16) := case when P_ITEM.ATTRIBUTE_02 = ''Block'' then null else P_ITEM.ATTRIBUTE_02 end; ',
'    L_ITEM_NAME       varchar2(1000) := APEX_PLUGIN.GET_INPUT_NAME_FOR_PAGE_ITEM(false);',
'    ',
'    K_COLOR_CLASSES   constant pls_integer := 45;',
'    ',
'begin',
'    -- Render the select list',
'    sys.HTP.p(''<select onchange="SetColor('''''' || upper(P_ITEM.name) || '''''')" id="''',
'              || P_ITEM.name',
'              || ''" class="selectlist apex-item-select ''',
'              || P_ITEM.ELEMENT_CSS_CLASSES',
'              || ''" name="''',
'              || L_ITEM_NAME',
'              || ''" width="''',
'              || P_ITEM.ELEMENT_WIDTH',
'              || ''" size="''',
'              || P_ITEM.ELEMENT_HEIGHT',
'              || ''" type="text" value="''',
'              || sys.HTF.ESCAPE_SC(P_PARAM.value)',
'              || ''" placeholder="''',
'              || P_ITEM.PLACEHOLDER',
'              || ''" />'');',
'    sys.HTP.p(''<option value="">''',
'              || P_ITEM.ATTRIBUTE_01',
'              || ''</option>'');',
'    for i in 1..K_COLOR_CLASSES loop',
'        sys.HTP.p(''<option '' || case when sys.HTF.ESCAPE_SC(P_PARAM.value) = ''u-color-'' || i || L_COLOR_TEXT then ''selected'' else null end  || '' class="u-color-''',
'                  || i',
'                  || L_COLOR_MODIFIER',
'                  || ''" value="u-color-''',
'                  || i',
'                  || L_COLOR_TEXT',
'                  || ''">u-color-''',
'                  || i',
'                  || L_COLOR_TEXT',
'                  || ''</option>'');',
'    end loop;',
'    sys.HTP.p(''</select>'');',
'',
'    -- add JavaScript file',
'    APEX_JAVASCRIPT.ADD_LIBRARY(P_NAME           => ''main'',',
'                                P_DIRECTORY      => P_PLUGIN.FILE_PREFIX ,',
'                                P_VERSION        => null,',
'                                P_SKIP_EXTENSION => false);',
' ',
'end RENDER_COLOR_LIST;'))
,p_api_version=>2
,p_render_function=>'RENDER_COLOR_LIST'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:READONLY:SOURCE:WIDTH:HEIGHT:PLACEHOLDER'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_help_text=>'See Github for comments and help.'
,p_version_identifier=>'0.1'
,p_about_url=>'https://github.com/madmexx2002/Apex-Color-List'
,p_plugin_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* ====================================================================================================================================================================================  */',
'-- Author:  Mark Lenzer',
'-- Date:    2021-03-13',
'-- Purpose: Select a color modifier from a select list plugin. Build the select list.',
'-- Update:  2022-02-05  Set Color onChange event',
'/* ====================================================================================================================================================================================  */'))
,p_files_version=>4
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(398501492214381423)
,p_plugin_id=>wwv_flow_api.id(395601626889294456)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Null Value Label'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_default_value=>'- Select Color -'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>true
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(398501851843381425)
,p_plugin_id=>wwv_flow_api.id(395601626889294456)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Color Modifier'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>true
,p_default_value=>'Block'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(398503230957381425)
,p_plugin_attribute_id=>wwv_flow_api.id(398501851843381425)
,p_display_sequence=>10
,p_display_value=>'Block'
,p_return_value=>'Block'
,p_help_text=>'Background color and foreground color'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(398503738854381425)
,p_plugin_attribute_id=>wwv_flow_api.id(398501851843381425)
,p_display_sequence=>20
,p_display_value=>'Text'
,p_return_value=>'-text'
,p_help_text=>'Foreground color'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(398502295251381425)
,p_plugin_attribute_id=>wwv_flow_api.id(398501851843381425)
,p_display_sequence=>30
,p_display_value=>'Background'
,p_return_value=>'-bg'
,p_help_text=>'Background color'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(398502764892381425)
,p_plugin_attribute_id=>wwv_flow_api.id(398501851843381425)
,p_display_sequence=>40
,p_display_value=>'Border'
,p_return_value=>'-border'
,p_help_text=>'Border color'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '66756E6374696F6E20536574436F6C6F7228704974656D494429207B0D0A202020202428272327202B20704974656D4944292E72656D6F7665436C6173732866756E6374696F6E2028696E6465782C20636C6173734E616D6529207B0D0A202020202020';
wwv_flow_api.g_varchar2_table(2) := '202072657475726E2028636C6173734E616D652E6D61746368282F285E7C5C7329752D636F6C6F722D5C532B2F6729207C7C205B5D292E6A6F696E28272027293B0D0A202020207D292E616464436C617373282428272327202B20704974656D4944292E';
wwv_flow_api.g_varchar2_table(3) := '76616C2829202B20272D626727293B0D0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(289900595008846086)
,p_plugin_id=>wwv_flow_api.id(395601626889294456)
,p_file_name=>'main.js'
,p_mime_type=>'application/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
prompt --application/end_environment
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
