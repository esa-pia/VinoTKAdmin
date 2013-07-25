/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
  
  /* Toolbars */
  config.language = 'fr';
  config.fontSize_defaultLabel = '12px',
  config.font_defaultLabel = 'Arial',
  config.toolbar = 'Easy';
  config.autoParagraph = false;
  config.enterMode = CKEDITOR.ENTER_BR;
  config.shiftEnterMode = CKEDITOR.ENTER_P;
  config.toolbar_Easy =
    [
        ['Source','-','Preview'],
        ['Cut','Copy','Paste','PasteText','PasteFromWord',],
        ['Undo','Redo','-','SelectAll','RemoveFormat'],
        ['Styles','Format'], ['Subscript', 'Superscript', 'TextColor','BGColor'], ['Maximize','-'], '/',
        ['Bold','Italic','Underline','Strike'], ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['Link','Unlink'],
        ['HorizontalRule','SpecialChar']
    ];
};
