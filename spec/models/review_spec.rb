require 'rails_helper'

describe Review, type: :model do
  describe '検索ができること' do
    it 'タイトルで検索ができること' do
      book1 = create(:book, title: 'プログラミング言語Ruby')
      book2 = create(:book, title: 'プログラミング言語Java')
      book3 = create(:book, title: 'Effective Ruby')
      review1 = create(:review, book: book1)
      review2 = create(:review, book: book2)
      review3 = create(:review, book: book3)

      ruby_reviews = Review.search_keyword('Ruby')
      expect(ruby_reviews.size).to eq 2
      expect(ruby_reviews).to include review1
      expect(ruby_reviews).to include review3

      programming_reviews = Review.search_keyword('プログラミング')
      expect(programming_reviews.size).to eq 2
      expect(programming_reviews).to include review1
      expect(programming_reviews).to include review2

      perl_reviews = Review.search_keyword('Perl')
      expect(perl_reviews.size).to eq 0
    end

    it '読書状況で検索ができること' do
      review1 = create(:review, status: 0)
      review2 = create(:review, status: 1)
      review3 = create(:review, status: 1)
      review4 = create(:review, status: 2)

      reviews0 = Review.search_status(0)
      expect(reviews0.size).to eq 1
      expect(reviews0).to include review1

      reviews1 = Review.search_status(1)
      expect(reviews1.size).to eq 2
      expect(reviews1).to include review2
      expect(reviews1).to include review3

      reviews9 = Review.search_status(9)
      expect(reviews9.size).to eq 0
    end

    it '評価で検索ができること' do
      review1 = create(:review, rank: 0)
      review2 = create(:review, rank: 1)
      review3 = create(:review, rank: 1)
      review4 = create(:review, rank: 2)

      reviews0 = Review.search_rank(0)
      expect(reviews0.size).to eq 1
      expect(reviews0).to include review1

      reviews1 = Review.search_rank(1)
      expect(reviews1.size).to eq 2
      expect(reviews1).to include review2
      expect(reviews1).to include review3

      reviews9 = Review.search_rank(9)
      expect(reviews9.size).to eq 0
    end

    it 'カテゴリーで検索ができること' do
      review1 = create(:review, category_id: 0)
      review2 = create(:review, category_id: 1)
      review3 = create(:review, category_id: 1)
      review4 = create(:review, category_id: 2)

      reviews0 = Review.search_category_id(0)
      expect(reviews0.size).to eq 1
      expect(reviews0).to include review1

      reviews1 = Review.search_category_id(1)
      expect(reviews1.size).to eq 2
      expect(reviews1).to include review2
      expect(reviews1).to include review3

      reviews9 = Review.search_category_id(9)
      expect(reviews9.size).to eq 0
    end

    it 'タグで検索ができること' do
      tag1 = Tag.create(id: 1)
      tag2 = Tag.create(id: 2)
      tag3 = Tag.create(id: 3)
      review1 = create(:review)
      review2 = create(:review)
      review3 = create(:review)
      review1.tags << [tag1, tag2]
      review2.tags << [tag2, tag3]
      review3.tags << [tag3, tag1]

      reviews1 = Review.search_tag_id(1)
      expect(reviews1.size).to eq 2
      expect(reviews1).to include review1
      expect(reviews1).to include review3

      reviews0 = Review.search_tag_id(9)
      expect(reviews0.size).to eq 0
    end

    it 'タイトル・読書状況・評価・カテゴリー・タグでAND検索ができること' do
      book0 = create(:book, title: 'プログラミング言語Ruby')
      book1 = create(:book, title: 'プログラミング言語Java')
      tag0 = Tag.create(id: 0)
      tag1 = Tag.create(id: 1)
      review1 = create(:review, book: book0, status: 0, rank: 0, category_id: 0); review1.tags << tag0
      review2 = create(:review, book: book1, status: 0, rank: 0, category_id: 0); review2.tags << tag0
      review3 = create(:review, book: book0, status: 1, rank: 0, category_id: 0); review3.tags << tag0
      review4 = create(:review, book: book0, status: 0, rank: 1, category_id: 0); review4.tags << tag0
      review5 = create(:review, book: book0, status: 0, rank: 0, category_id: 1); review5.tags << tag0
      review6 = create(:review, book: book0, status: 0, rank: 0, category_id: 0); review6.tags << tag1

      review_search_form = ReviewSearchForm.new(keyword: "Ruby", status: 0, rank: 0, category_id: 0, tag_id: 0)
      reviews = Review.search(review_search_form)
      expect(reviews.size).to eq 1
      expect(reviews).to include review1
    end
  end

  it 'タグ名をカンマ区切りでセットできること' do
    review = create(:review, tag_names: 'tag0')
    review.tag_names = 'tag1, tag2,tag3, tag3 ,,, tag4  ,tag5 '

    tags = review.tags
    expect(tags.size).to eq 5
    expect(tags[0].tag_name).to eq 'tag1'
    expect(tags[1].tag_name).to eq 'tag2'
    expect(tags[2].tag_name).to eq 'tag3'
    expect(tags[3].tag_name).to eq 'tag4'
    expect(tags[4].tag_name).to eq 'tag5'
  end

  it 'タグ名をカンマ区切りで取得できること' do
    review = build(:review)
    review.tags.build(tag_name: 'tag1')
    review.tags.build(tag_name: 'tag2')
    review.tags.build(tag_name: 'tag3')
    review.save

    expect(review.tag_names).to eq 'tag1, tag2, tag3'
  end
end
