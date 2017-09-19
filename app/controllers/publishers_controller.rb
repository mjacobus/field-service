require 'domain_error'

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
    begin
      find_publisher.destroy
      notice = { notice: t('publishers.destroyed') }
    rescue DomainError
      notice = { alert:  t('publishers.cannot_destroy') }
    end

    redirect_to publishers_url, notice
  end

  private

  def find_publisher
    Publisher.find(params[:id])
  end

  def publisher_params
    params.require(:publisher).permit(:name, :email, :phone, :congregation_member)
  end
end
