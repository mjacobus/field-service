class PublishersController < AuthenticatedController
  def index
    publishers = Publisher.all.sorted
    @publishers_decorator = create_decorator(PublishersDecorator, publishers)
  end

  def show
    @publisher_decorator = create_decorator(PublisherDecorator, find_publisher)
  end

  def new
    @publisher_decorator = create_decorator(PublisherDecorator, Publisher.new)
  end

  def edit
    @publisher_decorator = create_decorator(PublisherDecorator, find_publisher)
  end

  def create
    publisher = Publisher.new(publisher_params)
    @publisher_decorator = create_decorator(PublisherDecorator, publisher)

    if publisher.save
      redirect_to publisher, notice: t('publishers.created')
      return
    end

    render :new
  end

  def update
    publisher = find_publisher
    @publisher_decorator = create_decorator(PublisherDecorator, publisher)

    if publisher.update(publisher_params)
      redirect_to publisher, notice: t('publishers.updated')
      return
    end

    render :edit
  end

  def destroy
    find_publisher.destroy
    redirect_to publishers_url, notice: t('publishers.destroyed')
  end

  private

  def find_publisher
    Publisher.find(params[:id])
  end

  def publisher_params
    params.require(:publisher).permit(:name, :email, :phone)
  end
end
