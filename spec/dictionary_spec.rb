# frozen_string_literal: true

require 'spec_helper'
require 'flico/dictionary'

describe Flico::Dictionary do
  let(:subject) { described_class.new }

  context '#words' do
    let(:count) { 3 }
    let(:words) { subject.words(count) }

    it 'should not be empty' do
      expect(words).to_not be_empty
    end

    it 'should return 3 random words' do
      expect(words.count).to eq count
    end
  end
end
