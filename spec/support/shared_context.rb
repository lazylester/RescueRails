RSpec.shared_context 'signed in admin' do
  let(:admin) { create(:user, :admin) }
  allow(request.env['warden']).to receive(:authenticate!).and_return(admin)
  allow(controller).to receive(:current_user).and_return(admin)
end

RSpec.shared_context 'signed in user' do
  let(:user) { create(:user) }

  allow(request.env['warden']).to receive(:authenticate!).and_return(user)
  allow(controller).to receive(:current_user).and_return(user)
end
