# frozen_string_literal: true

module UkCountyLocator
  module Polygons
    # rubocop:disable Metrics/ModuleLength
    module HistoricCountyAliases
      HISTORIC_COUNTY_ALIASES = {
        'Aber' => 'Aberdeenshire',
        'County of Aberdeen' => 'Aberdeenshire',
        'Siorrachd Obar Dheathain' => 'Aberdeenshire',
        'Obar Dheathain' => 'Aberdeenshire',
        'Angl' => 'Anglesey',
        'Ynys Mon' => 'Anglesey',
        'Ynys Môn' => 'Anglesey',
        'Sir Fôn' => 'Anglesey',
        'Sir Môn' => 'Anglesey',
        'Sir Fon' => 'Anglesey',
        'Sir Mon' => 'Anglesey',
        'Aonghas' => 'Angus',
        'County Antrim' => 'Antrim',
        'Co Antrim' => 'Antrim',
        'Contae Aontroma' => 'Antrim',
        'Aontroma' => 'Antrim',
        'Coontie Antrìm' => 'Antrim',
        'Argyll' => 'Argyllshire',
        'Argyle' => 'Argyllshire',
        'Earra-Ghàidheal' => 'Argyllshire',
        'Earra-Ghaidheal' => 'Argyllshire',
        'Co Armagh' => 'Armagh',
        'County Armagh' => 'Armagh',
        'Contae Ard Mhacha' => 'Armagh',
        'Ard Mhacha' => 'Armagh',
        'Coontie Airmagh' => 'Armagh',
        'Airmagh' => 'Armagh',
        'Coontie Armagh' => 'Armagh',
        'Ayr' => 'Ayrshire',
        'Siorrachd Inbhir Àir' => 'Ayrshire',
        'Inbhir Àir' => 'Ayrshire',
        'Inbhir Air' => 'Ayrshire',
        'Banff' => 'Banffshire',
        'Siorrachd Bhanbh' => 'Banffshire',
        'Bhanbh' => 'Banffshire',
        'Beds' => 'Bedfordshire',
        'Berks' => 'Berkshire',
        'Berwick' => 'Berwickshire',
        'Bhearaig' => 'Berwickshire',
        'Siorrachd Bhearaig' => 'Berwickshire',
        'Breconshire' => 'Brecknockshire',
        'Brecon' => 'Brecknockshire',
        'Brecknockshire' => 'Brecknockshire',
        'Brecknock' => 'Brecknockshire',
        'Brycheiniog' => 'Brecknockshire',
        'Sir Brycheiniog' => 'Brecknockshire',
        'Brecks' => 'Brecknockshire',
        'Bcshire' => 'Brecknockshire',
        'Brecs' => 'Brecknockshire',
        'Bucks' => 'Buckinghamshire',
        'Bute' => 'Buteshire',
        'Bhòid' => 'Buteshire',
        'Bhoid' => 'Buteshire',
        'Siorrachd Bhòid' => 'Buteshire',
        'Siorrachd Bhoid' => 'Buteshire',
        'County of Bute' => 'Buteshire',
        'Caerns' => 'Caernarfonshire',
        'Carnarvonshire' => 'Caernarfonshire',
        'Carnarvon' => 'Caernarfonshire',
        'Caernarvon' => 'Caernarfonshire',
        'Gaernarfon' => 'Caernarfonshire',
        'Sir Gaernarfon' => 'Caernarfonshire',
        'Carn' => 'Caernarfonshire',
        'Caith' => 'Caithness',
        'Gallaibh' => 'Caithness',
        'Cambs' => 'Cambridgeshire',
        'Cards' => 'Cardiganshire',
        'Cardigan' => 'Cardiganshire',
        'Sir Aberteifi' => 'Cardiganshire',
        'Aberteifi' => 'Cardiganshire',
        'Sir Ceredigion' => 'Cardiganshire',
        'Ceredigion' => 'Cardiganshire',
        'Carms' => 'Carmarthenshire',
        'Carmarthen' => 'Carmarthenshire',
        'Sir Gaerfyrddin' => 'Carmarthenshire',
        'Gaerfyrddin' => 'Carmarthenshire',
        'Ches' => 'Cheshire',
        'Clackm' => 'Clackmannanshire',
        'Siorrachd Chlach Mhanann' => 'Clackmannanshire',
        'Chlach Mhanann' => 'Clackmannanshire',
        'Corn' => 'Cornwall',
        'Cornw' => 'Cornwall',
        'Cumb' => 'Cumberland',
        'Denbigh' => 'Denbighshire',
        'Denbs' => 'Denbighshire',
        'Sir Ddinbych' => 'Denbighshire',
        'Ddinbych' => 'Denbighshire',
        'Derbs' => 'Derbyshire',
        'Dev' => 'Devon',
        'Dor' => 'Dorset',
        'County Down' => 'Down',
        'Co Down' => 'Down',
        'Contae an Dúin' => 'Down',
        'Contae an Duin' => 'Down',
        'Dúin' => 'Down',
        'Duin' => 'Down',
        'Coontie Doon' => 'Down',
        'Doon' => 'Down',
        'Countie Doun' => 'Down',
        'Doun' => 'Down',
        'Dumfries' => 'Dumfriesshire',
        'Siorrachd Dhùn Phris' => 'Dumfriesshire',
        'Dhùn Phris' => 'Dumfriesshire',
        'Dhun Phris' => 'Dumfriesshire',
        'Dunbar' => 'Dunbartonshire',
        'Siorrachd Dhùn Breatann' => 'Dunbartonshire',
        'Siorrachd Dhun Breatann' => 'Dunbartonshire',
        'Dhùn Breatann' => 'Dunbartonshire',
        'Dhun Breatann' => 'Dunbartonshire',
        'Durham' => 'County Durham',
        'Co Durham' => 'County Durham',
        'Co Dur' => 'County Durham',
        'Dur' => 'County Durham',
        'East Loth' => 'East Lothian',
        'E Lothian' => 'East Lothian',
        'E Loth' => 'East Lothian',
        'Lodainn an Ear' => 'East Lothian',
        'Fermanagh' => 'County Fermanagh',
        'Co Fermanagh' => 'County Fermanagh',
        'Contae Fhear Manach' => 'County Fermanagh',
        'Fhear Manach' => 'County Fermanagh',
        'Contae Fir Manach' => 'County Fermanagh',
        'Fir Manach' => 'County Fermanagh',
        'Coontie Fermanay' => 'County Fermanagh',
        'Fermanay' => 'County Fermanagh',
        'Fìobha' => 'Fife',
        'Fiobha' => 'Fife',
        'Flint' => 'Flintshire',
        'Flints' => 'Flintshire',
        'Sir y Fflint' => 'Flintshire',
        'Fflint' => 'Flintshire',
        'Glamorganshire' => 'Glamorgan',
        'Glam' => 'Glamorgan',
        'Sir Forgannwg' => 'Glamorgan',
        'Forgannwg' => 'Glamorgan',
        'Sir Morgannwg' => 'Glamorgan',
        'Morgannwg' => 'Glamorgan',
        'Glos' => 'Gloucestershire',
        'Gloucs' => 'Gloucestershire',
        'Hants' => 'Hampshire',
        'Here' => 'Herefordshire',
        'Heref' => 'Herefordshire',
        'Herts' => 'Hertfordshire',
        'Hunts' => 'Huntingdonshire',
        'Inver' => 'Inverness-shire',
        'Siorrachd Inbhir Nis' => 'Inverness-shire',
        'Inbhir Nis' => 'Inverness-shire',
        'Kincar' => 'Kincardineshire',
        'The Mearns' => 'Kincardineshire',
        "A' Mhaoirne" => 'Kincardineshire',
        'Kinross' => 'Kinross-shire',
        'Ceann Rois' => 'Kinross-shire',
        'Kirkcud' => 'Kirkcudbrightshire',
        'Cille Chuithbeirt' => 'Kirkcudbrightshire',
        'Lanark' => 'Lanarkshire',
        'Siorrachd Lannraig' => 'Lanarkshire',
        'Lannraig' => 'Lanarkshire',
        'Lancs' => 'Lancashire',
        'Leics' => 'Leicestershire',
        'Lincs' => 'Lincolnshire',
        'Co Londonderry' => 'Londonderry',
        'County Londonderry' => 'Londonderry',
        'County Derry' => 'Londonderry',
        'Derry' => 'Londonderry',
        'Co Derry' => 'Londonderry',
        'Contae Dhoire' => 'Londonderry',
        'Dhoire' => 'Londonderry',
        'Coontie Lunnonderrie' => 'Londonderry',
        'Lunnonderrie' => 'Londonderry',
        'Merion' => 'Merionethshire',
        'Merioneth' => 'Merionethshire',
        'Sir Feirionnydd' => 'Merionethshire',
        'Feirionnydd' => 'Merionethshire',
        'Sir Meirionydd' => 'Merionethshire',
        'Meirionydd' => 'Merionethshire',
        'Sir Meirion' => 'Merionethshire',
        'Meirion' => 'Merionethshire',
        'Mx' => 'Middlesex',
        'Middx' => 'Middlesex',
        'Mddx' => 'Middlesex',
        "M'sex" => 'Middlesex',
        'Midloth' => 'Midlothian',
        'Meadhan Lodainn' => 'Midlothian',
        'Mons' => 'Monmouthshire',
        'Mon' => 'Monmouthshire',
        'Monmouth' => 'Monmouthshire',
        'Monshire' => 'Monmouthshire',
        'Sir Fynwy' => 'Monmouthshire',
        'Fynwy' => 'Monmouthshire',
        'Sir Mynwy' => 'Monmouthshire',
        'Mynwy' => 'Monmouthshire',
        'Mont' => 'Montgomeryshire',
        'Montg' => 'Montgomeryshire',
        'Montgomery' => 'Montgomeryshire',
        'Sir Drefaldwyn' => 'Montgomeryshire',
        'Drefaldwyn' => 'Montgomeryshire',
        'Sir Maldwyn' => 'Montgomeryshire',
        'Maldwyn' => 'Montgomeryshire',
        'Moray' => 'Morayshire',
        'County of Moray' => 'Morayshire',
        'Moireibh' => 'Morayshire',
        'Nairn' => 'Nairnshire',
        'County of Nairn' => 'Nairnshire',
        'Siorrachd Inbhir Narann' => 'Nairnshire',
        'Inbhir Narann' => 'Nairnshire',
        'Norf' => 'Norfolk',
        'Northants' => 'Northamptonshire',
        'Northumb' => 'Northumberland',
        'Northd' => 'Northumberland',
        'Notts' => 'Nottinghamshire',
        'Orkney Islands' => 'Orkney',
        'Arcaibh' => 'Orkney',
        'Oxon' => 'Oxfordshire',
        'Peebles' => 'Peeblesshire',
        'Siorrachd nam Pùballan' => 'Peeblesshire',
        'Siorrachd nam Puballan' => 'Peeblesshire',
        'nam Pùballan' => 'Peeblesshire',
        'nam Puballan' => 'Peeblesshire',
        'Pembs' => 'Pembrokeshire',
        'Pem' => 'Pembrokeshire',
        'Pemb' => 'Pembrokeshire',
        'Pembroke' => 'Pembrokeshire',
        'Sir Benfro' => 'Pembrokeshire',
        'Benfro' => 'Pembrokeshire',
        'Sir Penfro' => 'Pembrokeshire',
        'Penfro' => 'Pembrokeshire',
        'Perth' => 'Perthshire',
        'Siorrachd Pheairt' => 'Perthshire',
        'Pheairt' => 'Perthshire',
        'Radnor' => 'Radnorshire',
        'Rad' => 'Radnorshire',
        'Rads' => 'Radnorshire',
        'Sir Raesyfed' => 'Radnorshire',
        'Raesyfed' => 'Radnorshire',
        'Sir Maesyfed' => 'Radnorshire',
        'Maesyfed' => 'Radnorshire',
        'Renfrew' => 'Renfrewshire',
        'Siorrachd Rinn Friù' => 'Renfrewshire',
        'Siorrachd Rinn Friu' => 'Renfrewshire',
        'Rinn Friù' => 'Renfrewshire',
        'Rinn Friu' => 'Renfrewshire',
        'Ross-shire and Cromartyshire' => 'Ross-shire & Cromartyshire',
        'Ross' => 'Ross-shire & Cromartyshire',
        'Crom' => 'Ross-shire & Cromartyshire',
        'Ross and Crom' => 'Ross-shire & Cromartyshire',
        'Ross & Crom' => 'Ross-shire & Cromartyshire',
        'Ross-shire' => 'Ross-shire & Cromartyshire',
        'Cromartyshire' => 'Ross-shire & Cromartyshire',
        'Siorrachd Rois' => 'Ross-shire & Cromartyshire',
        'Rois' => 'Ross-shire & Cromartyshire',
        'Siorrachd Chromba' => 'Ross-shire & Cromartyshire',
        'Chromba' => 'Ross-shire & Cromartyshire',
        'Roxb' => 'Roxburghshire',
        'Siorrachd Rosbroig' => 'Roxburghshire',
        'Rosbroig' => 'Roxburghshire',
        'Rutlandshire' => 'Rutland',
        'Rut' => 'Rutland',
        'Selk' => 'Selkirkshire',
        'Siorrachd Shalcraig' => 'Selkirkshire',
        'Shalcraig' => 'Selkirkshire',
        'Shetland Islands' => 'Shetland',
        'Zetland' => 'Shetland',
        'Sealtainn' => 'Shetland',
        'Shrops' => 'Shropshire',
        'Salop' => 'Shropshire',
        'Somersetshire' => 'Somerset',
        'Som' => 'Somerset',
        'Staffs' => 'Staffordshire',
        'Staf' => 'Staffordshire',
        'Stirl' => 'Stirlingshire',
        'Siorrachd Sruighlea' => 'Stirlingshire',
        'Sruighlea' => 'Stirlingshire',
        'Suff' => 'Suffolk',
        'Surr' => 'Surrey',
        'Sy' => 'Surrey',
        'Sx' => 'Sussex',
        'Ssx' => 'Sussex',
        'Suther' => 'Sutherland',
        'Cataibh' => 'Sutherland',
        'Co Tyrone' => 'County Tyrone',
        'Tyrone' => 'County Tyrone',
        'Tir Eoghain' => 'County Tyrone',
        'Tír Eoghain' => 'County Tyrone',
        'Contae Tír Eoghain' => 'County Tyrone',
        'Contae Tir Eoghain' => 'County Tyrone',
        'Coontie Owenslann' => 'County Tyrone',
        'Owenslann' => 'County Tyrone',
        'Warks' => 'Warwickshire',
        'War' => 'Warwickshire',
        'Warw' => 'Warwickshire',
        'W Lothian' => 'West Lothian',
        'West Loth' => 'West Lothian',
        'W Loth' => 'West Lothian',
        'Lodainn an Iar' => 'West Lothian',
        'Westm' => 'Westmorland',
        'Wigtown' => 'Wigtownshire',
        'Siorrachd Bhaile na h-Ùige' => 'Wigtownshire',
        'Siorrachd Bhaile na h-Uige' => 'Wigtownshire',
        'Bhaile na h-Ùige' => 'Wigtownshire',
        'Bhaile na h-Uige' => 'Wigtownshire',
        'Wilts' => 'Wiltshire',
        'Worcs' => 'Worcestershire',
        'Worsts' => 'Worcestershire',
        'Yorks' => 'Yorkshire'
      }.freeze
    end
    # rubocop:enable Metrics/ModuleLength
  end
end
