class Member < ActiveRecord::Base
  # constants
  GENDERS = ['MALE', 'FEMALE', 'TRANSGENDER', 'OTHER']
  DIAGNOSES = ['HIV+', 'AIDS', 'HIV+ & Hep C']
  ETHNICITIES = ['ABORIGINAL', 'STATUS', 'NON-ABORIGINAL', 'UNDISCLOSED']
  PROVINCES = ['ALBERTA', 'BRITISH COLUMBIA', 'MANITOBA', 'NEW BRUNSWICK', 'NEWFOUNDLAND AND LABRADOR', 'NOVA SCOTIA', 'ONTARIO', 'PRINCE EDWARD ISLAND', 'QUEBEC', 'SASKATCHEWAN', 'NORTHWEST TERRITORIES', 'NUNAVUT', 'YUKON']

  has_many :notes, :dependent => :destroy
  has_many :goals, :dependent => :destroy

  attr_accessible :name, :birthdate, :gender, :address, :city, :province, :postalCode, :telephone, :carecard, :sin, :ethnicity, :diagnosis, :arv, :arvDate, :doctor, :doctorPhone, :placeDiagnosis, :dateDiagnosis, :active, :methadone, :emergency_contact_name, :emergency_contact_phone

  validates :name, :gender, :ethnicity, :diagnosis, :presence => true
  validates :gender, :inclusion => { :in => GENDERS }
  validates :ethnicity, :inclusion => { :in => ETHNICITIES }
  validates :diagnosis, :inclusion => { :in => DIAGNOSES }

  def self.incomplete
    Member.all.select { |m|
      m.name.blank? || m.gender.blank? || m.ethnicity.blank? || m.diagnosis.blank? || m.sin.blank? || m.address.blank? || m.city.blank? || m.birthdate == nil || m.province.blank? || m.postalCode.blank? || m.telephone.blank? || m.carecard.blank? || m.doctor.blank? || m.doctorPhone.blank? || m.emergency_contact_name.blank? || m.emergency_contact_phone.blank?}
  end
end
