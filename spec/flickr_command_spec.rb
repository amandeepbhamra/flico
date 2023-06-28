# frozen_string_literal: true

require 'spec_helper'
require 'flico/flickr_command'

describe Flico::FlickrCommand do
  let(:search_results) do
    [
      {
        'id' => '33472607802',
        'owner' => '78759190@N05',
        'secret' => '42e011bcf5',
        'server' => '2805',
        'farm' => 3,
        'title' => 'Volkswagen Golf in Luxembourg',
        'ispublic' => 1,
        'isfriend' => 0,
        'isfamily' => 0
      }
    ]
  end
  let(:sizes_results) do
    [
      {
        'label' => 'Square',
        'width' => 75,
        'height' => 75,
        'source' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5_s.jpg',
        'url' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5/sizes/sq/',
        'media' => 'photo'
      },
      {
        'label' => 'Large Square',
        'width' => '150',
        'height' => '150',
        'source' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5_q.jpg',
        'url' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5/sizes/q/',
        'media' => 'photo'
      },

      {
        'label' => 'Thumbnail',
        'width' => '100',
        'height' => '66',
        'source' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5_t.jpg',
        'url' => 'https://farm3.staticflickr.com/2805/33472607802_42e011bcf5/sizes/t/',
        'media' => 'photo'
      }
    ]
  end
  let(:subject) { described_class.new(search_command:, sizes_command:) }
  let(:search_command) { double('search', call: search_results) }
  let(:sizes_command) { double('sizes', call: sizes_results) }

  context 'search success' do
    it 'should return image url for search keyword' do
      expect(subject.call('Volkswagen Golf in Luxembourg')).to eq('https://farm3.staticflickr.com/2805/33472607802_42e011bcf5_q.jpg')
    end
  end
end
