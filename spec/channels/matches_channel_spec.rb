# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MatchesChannel do
  let(:match) { create(:match) }

  before do
    stub_connection
  end

  it 'subscribes to a stream when match id is provided' do
    subscribe(match: match)

    expect(subscription).to be_confirmed
  end
end
