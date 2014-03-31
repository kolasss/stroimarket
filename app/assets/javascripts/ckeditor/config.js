CKEDITOR.editorConfig = function( config )
{

  // config.toolbar = 'article';
  // config.toolbar_article = [
  //   { name: 'document', items: [ 'NewPage' ] },
  //   { name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
  //   { name: 'editing', items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
  //   { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule', 'Smiley', 'SpecialChar', 'Iframe' ] },
  //   { name: 'links', items: [ 'Link', 'Unlink', 'Anchor' ] },
  //   '/',
  //   { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
  //   { name: 'styles', items: [ 'Styles', 'Format' ] },
  //   { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
  //   { name: 'alignment', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
  //   { name: 'tools', items: [ 'Maximize', '-', 'Preview' ] }
  // ];

  config.toolbar_stroimarket = [
    { name: 'paragraph', items: [ 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
    { name: 'insert', items: [ 'Image', 'Table', 'HorizontalRule' ] },
    { name: 'links', items: [ 'Link', 'Unlink' ] },
    { name: 'tools', items: [ 'Maximize', '-', 'ShowBlocks', 'Source', '-', 'Preview' ] },
    '/',
    { name: 'basicstyles', items: [ 'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
    { name: 'styles', items: [ 'Format' ] },
    { name: 'alignment', items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock' ] },
  ];
  config.toolbar = 'stroimarket';

  config.skin = 'bootstrapck';
};
