require 'spec_helper'

describe Player do
  it_behaves_like "a GameObject or descendant"
  it_behaves_like "a Movable"
  it_behaves_like "a Container"

  it "gets a location of the starter room if not otherwise specified" do
    p = Player.create!(location: nil)
    expect(p.location).to eq(Room.starting)
  end

  it "still can be given a location" do
    r = Room.create!
    p = Player.create!(location: r)
    expect(p.location).to eq(r)
  end

  context ".superadmin" do
    it "returns the actual superadmin player" do
      expect(Player.superadmin._special).to eq(:superadmin_player)
    end
  end

  it { is_expected.to have_fields(:locale) }

  context ".notify & .notify_raw" do
    before(:each) do
      @p = Player.create!(location: nil)
      @message = "Waffle time!"
      @server = stub_carbonmu_server
      @args = {foo: "bar"}
    end

    it ".notify calls Server.notify_player" do
      expect(@server).to receive(:notify_player).with(@p, @message, @args)
      @p.notify(@message, @args)
    end

    it ".notify_raw calls Server.notify_player_raw" do
      expect(@server).to receive(:notify_player_raw).with(@p, @message)
      @p.notify_raw(@message)
    end
  end

  context ".translate_message" do
    it "calls I18n.t with the proper locale" do
      @locale = "nl"
      @args = { foo: "bar" }
      @merged_args = @args.merge(locale: @locale)
      @p = Player.create!(location: nil, locale: @locale)
      @message = "I'm on fire!"
      @message_translated = "Ik ben op brand!"

      expect(I18n).to receive(:t).with(@message, @merged_args) { @message_translate }
      @p.translate_message(@message, @args)
    end
  end
end
