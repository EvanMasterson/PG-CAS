class DashboardController < ApplicationController
	include Secured
  	before_action :current_user

  	LOW_RISK_COUNTRIES = [
		"Switzerland",
		"Austria",
		"Cyprus",
		"Slovakia",	
		"San Marino",
		"Malta",
		"Thailand",
		"New Zealand",
		"Fiji",
		"British Virgin Islands",
		"Laos",
		"New Caledonia",
		"Taiwan"
	].freeze

	MEDIUM_RISK_COUNTRIES = [
		"Andorra",
		"Afghanistan",
		"Antigua and Barbuda",
		"Anguilla",
		"Albania",
		"Armenia",
		"Angola",
		"Antarctica",
		"Argentina",
		"American Samoa",
		"Australia",
		"Aruba",
		"Åland",
		"Azerbaijan",
		"Bosnia and Herzegovina",
		"Barbados",
		"Bangladesh",
		"Belgium",
		"Burkina Faso",
		"Bulgaria",
		"Burundi",
		"Benin",
		"Saint-Barthélemy",
		"Bermuda",
		"Brunei",
		"Bolivia",
		"Bonaire",
		"Bahamas",
		"Bhutan",
		"Botswana",
		"Belarus",
		"Belize",
		"Canada",
		"Cocos [Keeling] Islands",
		"Congo",
		"Central African Republic",
		"Republic of the Congo",
		"Ivory Coast",
		"Cook Islands",
		"Chile",
		"Cameroon",
		"Colombia",
		"Costa Rica",
		"Cuba",
		"Cape Verde",
		"Curaçao",
		"Christmas Island",
		"Czech Republic",
		"Germany",
		"Djibouti",
		"Denmark",
		"Dominica",
		"Dominican Republic",
		"Ecuador",
		"Estonia",
		"Egypt",
		"Eritrea",
		"Spain",
		"Ethiopia",
		"Falkland Islands",
		"Federated States of Micronesia",
		"Faroe Islands",
		"Finland",
		"France",
		"Gabon",
		"United Kingdom",
		"Grenada",
		"Georgia",
		"French Guiana",
		"Guernsey",
		"Ghana",
		"Gibraltar",
		"Greenland",
		"Gambia",
		"Guinea",
		"Guadeloupe",
		"Equatorial Guinea",
		"Greece",
		"South Georgia and the South Sandwich Islands",
		"Guatemala",
		"Guam",
		"Guinea-Bissau",
		"Guyana",
		"Hong Kong",
		"Honduras",
		"Croatia",
		"Haiti",
		"Hungary",
		"Indonesia",
		"Ireland",
		"Israel",
		"Isle of Man",
		"British Indian Ocean Territory",
		"Iceland",
		"Italy",
		"Jersey",
		"Jamaica",
		"Hashemite Kingdom of Jordan",
		"Japan",
		"Kenya",
		"Kyrgyzstan",
		"Cambodia",
		"Kiribati",
		"Comoros",
		"Saint Kitts and Nevis",
		"North Korea",
		"Republic of Korea",
		"Cayman Islands",
		"Kazakhstan",
		"Saint Lucia",
		"Liechtenstein",
		"Liberia",
		"Lesotho",
		"Republic of Lithuania",
		"Luxembourg",
		"Latvia",
		"Libya",
		"Morocco",
		"Monaco",
		"Republic of Moldova",
		"Montenegro",
		"Saint Martin",
		"Marshall Islands",
		"Macedonia",
		"Mali",
		"Myanmar [Burma]",
		"Mongolia",
		"Macao",
		"Northern Mariana Islands",
		"Martinique",
		"Mauritania",
		"Montserrat",
		"Mauritius",
		"Maldives",
		"Malawi",
		"Malaysia",
		"Mozambique",
		"Namibia",
		"Niger",
		"Norfolk Island",
		"Nigeria",
		"Nicaragua",
		"Netherlands",
		"Norway",
		"Nepal",
		"Nauru",
		"Niue",
		"French Polynesia",
		"Papua New Guinea",
		"Poland",
		"Saint Pierre and Miquelon",
		"Pitcairn Islands",
		"Puerto Rico",
		"Palestine",
		"Portugal",
		"Palau",
		"Paraguay",
		"Réunion",
		"Romania",
		"Russia",
		"Rwanda",
		"Saudi Arabia",
		"Solomon Islands",
		"Seychelles",
		"Sudan",
		"Sweden",
		"Singapore",
		"Saint Helena",
		"Slovenia",
		"Svalbard and Jan Mayen",
		"Sierra Leone",
		"Senegal",
		"Somalia",
		"Suriname",
		"South Sudan",
		"São Tomé and Príncipe",
		"El Salvador",
		"Sint Maarten",
		"Syria",
		"Swaziland",
		"Turks and Caicos Islands",
		"Chad",
		"French Southern Territories",
		"Togo",
		"Tajikistan",
		"Tokelau",
		"East Timor",
		"Turkmenistan",
		"Tunisia",
		"Tonga",
		"Trinidad and Tobago",
		"Tuvalu",
		"Tanzania",
		"Ukraine",
		"Uganda",
		"U.S. Minor Outlying Islands",
		"Uruguay",
		"Uzbekistan",
		"Vatican City",
		"Saint Vincent and the Grenadines",
		"Venezuela",
		"U.S. Virgin Islands",
		"Vietnam",
		"Vanuatu",
		"Wallis and Futuna",
		"Samoa",
		"Kosovo",
		"Yemen",
		"Mayotte",
		"South Africa",
		"Zambia",
		"Zimbabwe"
	].freeze

	HIGH_RISK_COUNTRIES = [
		"India",
		"Pakistan",
		"Philippines",
		"Sri Lanka",
		"Lebanon",
		"China",
		"Iraq",
		"Iran",
		"Brazil",
		"Mexico",
		"Algeria",
		"Bahrain",
		"Oman",
		"Madagascar",
		"Panama",
		"Peru",
		"Serbia",
		"Turkey",
		"United Arab Emirates",
		"United States",
		"Qatar",
		"Kuwait"
	].freeze

	def show
		@user_details = @current_user
		@user_id = @current_user.id
		@auth0_user_id = @current_user.auth0_user_id
		@bearer_token = @current_user.bearer_token
		@email = @current_user.email
		@country = @current_user.country
		@pre_existing_conditions = @current_user.pre_existing_conditions
		calculate_risk
	end

	def determine_country_risk
		country_risk = 0
		return unless @current_user.country
		country_risk += 10 if HIGH_RISK_COUNTRIES.include?(ISO3166::Country[@current_user.country].name)
	   	country_risk += 5 if MEDIUM_RISK_COUNTRIES.include?(ISO3166::Country[@current_user.country].name)
	   	country_risk
	end

	PRE_EXISTING_CONDITIONS_RISK = {
		"Lung Disease" 		=> 13,
		"Elderly"			=> 15,
		"Immunocompromised" => 15,
		"Heart Disease"		=> 25,
		"Obesity"			=> 27,
		"Liver Disease"		=> 30,
		"Diabetes"			=> 40
	}

	def determine_pre_existing_conditions_risk
		condition_risk = 0
		return unless @current_user.pre_existing_conditions
		PRE_EXISTING_CONDITIONS_RISK.each do |k,v|
		condition_risk += v if @current_user.pre_existing_conditions.include?(k)
		end
		condition_risk
	end

	def determine_age_risk #logic based on https://www.cdc.gov/coronavirus/2019-ncov/need-extra-precautions/older-adults.html
		age_risk = 0
		return unless @current_user.age
		age_risk += 6 if @current_user.age.between?(19, 29)
		age_risk += 10 if @current_user.age.between?(30, 39)
		age_risk += 17 if @current_user.age.between?(40, 49)
		age_risk += 27 if @current_user.age.between?(50, 64)
		age_risk += 39 if @current_user.age.between?(65, 74)
		age_risk += 65 if @current_user.age.between?(75, 84)
		age_risk += 100 if @current_user.age >85
		age_risk
	end

	def calculate_risk 
	  user_risk = 0 #risk starts at 0
	  country_risk = determine_country_risk || 0
	  condition_risk = determine_pre_existing_conditions_risk || 0
	  age_risk = determine_age_risk || 0
	  user_risk += country_risk + condition_risk + age_risk
	  @user_risk
	  @current_user.update(:risk_score => user_risk)
	end
end
