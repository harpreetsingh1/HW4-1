require 'spec_helper'

  describe MoviesController do

    describe 'add director' do
      before :each do
        @m3 = mock(Movie, :title => "Alien", :director => "Ridley Scott", :id => "3")
        Movie.stub!(:find).with("3").and_return(@m3)
      end

      it 'should call update_attributes and redirect' do
        @m3.stub!(:update_attributes!).and_return(true)
        put :update, {:id => "3", :movie => @m3}
        response.should redirect_to(movie_path(@m3))
      end
  end
  describe 'happy path' do
    before :each do
      @m1 = mock(Movie, :title => "Star Wars", :director => "director", :id => "1")
      Movie.stub!(:find).with("1").and_return(@m1)
    end

    it 'should generate routing for similar movies' do
      { :post => movie_similar_path(1) }.should
      route_to(:controller => "movies", :action => "similar", :movie_id => "1")
    end

    it 'should call the model method that finds similar movies' do
      fake_results = [mock('Movie'), mock('Movie')]
      Movie.should_receive(:same_director).with('director').and_return(fake_results)
      get :similar, :movie_id => "1"
    end

    it 'should select the Similar template for rendering and make results available' do
      Movie.stub!(:same_director).with('director').and_return(@m1)
      get :similar, :movie_id => "1"
      response.should render_template('similar')
      assigns(:movies).should == @m1
    end
  end

  describe 'sad path' do
    before :each do
      @m3 = mock(Movie, :title => "Alien", :director => nil, :id => "3")
      Movie.stub!(:find).with("3").and_return(@m3)
    end

    it 'should generate routing for Similar Movies' do
      { :post => movie_similar_path(3) }.should
      route_to(:controller => "movies", :action => "similar", :movie_id => "3")
    end

    it 'should select the Index template for rendering and generate a flash' do
      get :similar, :movie_id => "3"
      response.should redirect_to(root_path)
      flash[:notice].should_not be_blank
    end
  end

  describe 'create and destroy' do
    it 'should create a new movie' do
      MoviesController.stub(:create).and_return(mock('Movie'))
      post :create, {:id => "1"}
    end

    it 'should destroy a movie' do
      m10 = mock(Movie, :id => "10", :title => "The Matrix", :director => "Larry and Andy Wachowski")
      Movie.stub!(:find).with("10").and_return(m10)
      m10.should_receive(:destroy)
      delete :destroy, {:id => "10"}
    end
  end
end
