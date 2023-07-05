# frozen_string_literal: true

require 'spec_helper'
require 'flico/flickr/base_api'

describe Flico::Flickr::BaseApi do
  let(:photo_url) do
    {
      'label' => 'Square',
      'width' => 75,
      'height' => 75,
      'source' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5_s.jpg',
      'url' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5/sizes/sq/',
      'media' => 'photo'
    }
  end

  let(:subject) { described_class.new }

  context 'search success' do
    before do
      ENV['FLICKR_KEY'] = 'FOO'
      ENV['FLICKR_SECRET'] = 'BAR'
    end

    it 'should return image url for search keyword' do
      allow_any_instance_of(Flico::Flickr::BaseApi).to receive(:flickraw_api).and_return(double('flickraw_api'))
      allow_any_instance_of(Flico::Flickr::BaseApi).to receive(:get_photo).and_return(photo_url)

      expect(subject.get_photo('Volkswagen Golf in Luxembourg')['source']).to eq('https://farm3.staticflickr.com/2805/33472607802_42e011bcf5_s.jpg')
    end
  end
end
