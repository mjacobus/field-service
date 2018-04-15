const templateReplace = (template, data) => {
  Object.keys(data).forEach(key => {
    template = template.replace(new RegExp('__' + key + '__', 'g'), data[key]);
  })

  return template;
};

const searchHouseholders = (query, containerSelector, template) => {
  const url = '/api/householders/search?q=' +  query;

  jQuery.ajax({ url }).success(response => {
    const html = response.data.map((item) => {
      return templateReplace(template, {
        name: item.name,
        address: item.address,
        url: item.links.edit,
        territoryUrl: item.links.territory,
        territoryName: item.territoryName,
      });
    })

    jQuery(containerSelector).show().html(html.join(''));
  });
}
