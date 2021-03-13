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
,p_default_workspace_id=>1600470833210778
,p_default_application_id=>400
,p_default_id_offset=>0
,p_default_owner=>'APEX201'
);
end;
/
 
prompt APPLICATION 400 - Auftragsportal Online
--
-- Application Export:
--   Application:     400
--   Name:            Auftragsportal Online
--   Date and Time:   16:32 Saturday March 13, 2021
--   Exported By:     DEV201
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 120000518900037470
--   Manifest End
--   Version:         20.1.0.00.13
--   Instance ID:     400145408901750
--

begin
  -- replace components
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/item_type/com_madmexx_color_list
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(120000518900037470)
,p_plugin_type=>'ITEM TYPE'
,p_name=>'COM.MADMEXX.COLOR_LIST'
,p_display_name=>'Color List'
,p_supported_ui_types=>'DESKTOP'
,p_supported_component_types=>'APEX_APPLICATION_PAGE_ITEMS:APEX_APPL_PAGE_IG_COLUMNS'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* ====================================================================================================================================================================================  */',
'-- Author:  ich@madmexx.com',
'-- Date:    13.03.21 10:17:03',
'-- Purpose: Select a color modifier from a select list plugin. Build the select list.',
'/* ====================================================================================================================================================================================  */',
'procedure RENDER_COLOR_LIST (',
'    P_ITEM    in  APEX_PLUGIN.T_ITEM',
'  , P_PLUGIN  in  APEX_PLUGIN.T_PLUGIN',
'  , P_PARAM   in  APEX_PLUGIN.T_ITEM_RENDER_PARAM',
'  , P_RESULT  in out nocopy APEX_PLUGIN.T_ITEM_RENDER_RESULT',
') is ',
'    -- Some modifications to the attribute 02',
'    LV_COLOR_MODIFIER  varchar2(16) := CASE WHEN P_ITEM.ATTRIBUTE_02 in (''Block'',''-border'') then null else P_ITEM.ATTRIBUTE_02 end; ',
'    LV_COLOR_TEXT  varchar2(16) := CASE WHEN P_ITEM.ATTRIBUTE_02 = ''Block'' then null else P_ITEM.ATTRIBUTE_02 end; ',
'',
'    LV_ITEM_NAME    varchar2(1000) := APEX_PLUGIN.GET_INPUT_NAME_FOR_PAGE_ITEM(FALSE);',
'begin',
'    apex_debug.info(SYS.HTF.ESCAPE_SC(P_PARAM.VALUE),9);',
'    -- Render the select list',
'    SYS.HTP.P(''<select id="''',
'              || P_ITEM.NAME',
'              || ''" class="selectlist apex-item-select ''',
'              || P_ITEM.ELEMENT_CSS_CLASSES',
'              || ''" name="''',
'              || LV_ITEM_NAME',
'              || ''" width="''',
'              || P_ITEM.ELEMENT_WIDTH',
'              || ''" size="''',
'              || P_ITEM.ELEMENT_HEIGHT',
'              || ''" type="text" value="''',
'              || SYS.HTF.ESCAPE_SC(P_PARAM.VALUE)',
'              || ''" placeholder="''',
'              || P_ITEM.PLACEHOLDER',
'              || ''" />'');',
'    SYS.HTP.P(''<option value="">''',
'              || P_ITEM.ATTRIBUTE_01',
'              || ''</option>'');',
'    for I in 1..45 loop',
'        SYS.HTP.P(''<option '' || case when SYS.HTF.ESCAPE_SC(P_PARAM.VALUE) = ''u-color-'' || I || LV_COLOR_TEXT then ''selected'' else null end  || '' class="u-color-''',
'                  || I',
'                  || LV_COLOR_MODIFIER',
'                  || ''" value="u-color-''',
'                  || I',
'                  || LV_COLOR_TEXT',
'                  || ''">u-color-''',
'                  || I',
'                  || LV_COLOR_TEXT',
'                  || ''</option>'');',
'    end loop;',
'    SYS.HTP.P(''</select>'');',
'end RENDER_COLOR_LIST;'))
,p_api_version=>2
,p_render_function=>'RENDER_COLOR_LIST'
,p_standard_attributes=>'VISIBLE:SESSION_STATE:READONLY:SOURCE:WIDTH:HEIGHT:PLACEHOLDER'
,p_substitute_attributes=>true
,p_reference_id=>118500209022341831
,p_subscribe_plugin_settings=>true
,p_help_text=>'See Github for comments and help.'
,p_version_identifier=>'0.1'
,p_about_url=>'https://github.com/madmexx2002/Apex-Color-List'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(122900384225124437)
,p_plugin_id=>wwv_flow_api.id(120000518900037470)
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
 p_id=>wwv_flow_api.id(122900743854124439)
,p_plugin_id=>wwv_flow_api.id(120000518900037470)
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
 p_id=>wwv_flow_api.id(122902122968124439)
,p_plugin_attribute_id=>wwv_flow_api.id(122900743854124439)
,p_display_sequence=>10
,p_display_value=>'Block'
,p_return_value=>'Block'
,p_help_text=>'Background color and foreground color'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(122902630865124439)
,p_plugin_attribute_id=>wwv_flow_api.id(122900743854124439)
,p_display_sequence=>20
,p_display_value=>'Text'
,p_return_value=>'-text'
,p_help_text=>'Foreground color'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(122901187262124439)
,p_plugin_attribute_id=>wwv_flow_api.id(122900743854124439)
,p_display_sequence=>30
,p_display_value=>'Background'
,p_return_value=>'-bg'
,p_help_text=>'Background color'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(122901656903124439)
,p_plugin_attribute_id=>wwv_flow_api.id(122900743854124439)
,p_display_sequence=>40
,p_display_value=>'Border'
,p_return_value=>'-border'
,p_help_text=>'Border color'
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
