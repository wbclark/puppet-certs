require 'spec_helper_acceptance'

describe 'certs' do
  before(:all) do
    on default, 'rm -rf /root/ssl-build'
  end

  context 'with default params' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) { 'include certs' }
    end

    describe package('katello-certs-tools') do
      it { is_expected.to be_installed }
    end

    describe x509_certificate('/etc/pki/katello-certs-tools/certs/katello-default-ca.crt') do
      it { should be_certificate }
      it { should be_valid }
      it { should have_purpose 'SSL server CA' }
      its(:issuer) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:subject) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:keylength) { should be >= 4096 }
    end

    describe x509_certificate('/etc/pki/katello-certs-tools/certs/katello-server-ca.crt') do
      it { should be_certificate }
      it { should be_valid }
      it { should have_purpose 'SSL server CA' }
      its(:issuer) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:subject) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:keylength) { should be >= 4096 }
    end

    describe x509_certificate('/etc/pki/katello/certs/katello-default-ca.crt') do
      it { should be_certificate }
      it { should be_valid }
      it { should have_purpose 'SSL server CA' }
      its(:issuer) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:subject) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:keylength) { should be >= 4096 }
    end

    describe x509_certificate('/etc/pki/katello/certs/katello-server-ca.crt') do
      it { should be_certificate }
      it { should be_valid }
      it { should have_purpose 'SSL server CA' }
      its(:issuer) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:subject) { should eq("C = US, ST = North Carolina, L = Raleigh, O = Katello, OU = SomeOrgUnit, CN = #{fact('fqdn')}") }
      its(:keylength) { should be >= 4096 }
    end

    describe x509_private_key('/etc/pki/katello/private/katello-default-ca.key') do
      it { should_not be_encrypted }
      it { should be_valid }
      it { should have_matching_certificate('/etc/pki/katello-certs-tools/certs/katello-default-ca.crt') }
    end
  end
end
