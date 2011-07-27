transliterations = {
  :'ä' => 'ae',
  :'ö' => 'oe',
  :'ü' => 'ue',
  :'Ä' => 'Ae',
  :'Ö' => 'Oe',
  :'Ü' => 'Ue',
  :'ß' => 'ss',
}

I18n.default_locale = :de
I18n.locale = :de
I18n.backend.store_translations(:de, :i18n => { :transliterate => { :rule => transliterations } })

