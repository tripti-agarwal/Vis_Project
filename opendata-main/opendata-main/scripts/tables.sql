constituents:                       select c.* into temporary tt from data.constituents c where c.constituentid in ( select distinct oc.constituentid from data.objects_constituents oc where oc.objectid in ( select distinct o.objectid from data.objects o where o.accessioned=1 ) ); alter table tt drop column biography, drop column constituentleonardoid, drop column fingerprint;
constituents_altnames:              select a.* into temporary tt from data.constituents_altnames a where a.constituentid in ( select distinct oc.constituentid from data.objects_constituents oc where oc.objectid in ( select distinct o.objectid from data.objects o where o.accessioned=1 ) ); alter table tt drop column fingerprint;
constituents_text_entries:          select * into temporary tt from data.constituents_text_entries where texttype='bibliography'; alter table tt drop column fingerprint, drop column tmstable, drop column tmsrefid;
locations:                          select * into temporary tt from data.locations; alter table tt drop column fingerprint;
media_items:                        select * into temporary tt from data.media_items; alter table tt drop column thumbnailpath, drop column imagepath, drop column transcript;
media_relationships:                select * into temporary tt from data.media_relationships;
object_associations:                select distinct a.* into temporary tt from data.object_associations a join data.objects o on o.objectid in (a.parentobjectid,a.childobjectid) where o.accessioned=1; alter table tt drop column fingerprint, drop column associationid;
objects:                            select * into temporary tt from data.objects where accessioned=1; alter table tt add customPrintURL character varying(512) NULL, add downloadable integer NULL; update tt set customprinturl = p.url from data.objects_customprint_urls p where objectid=p.tmsobjectid; update tt set downloadable = 0; update tt set downloadable = 1 from data.objects_ngaimages_status i where objectid=i.tmsobjectid; alter table tt drop column fingerprint, drop column oldaccessionnum, drop column objectleonardoid, drop column isiad, drop column imagecopyright, drop column canshowimagery, drop column thumbnailsprohibited, drop column maxDerivativeExtent, drop column zoompermissiongranted, drop column ispublic, drop column downloadable, drop column catalograisonneref;
objects_altnums:                    select a.* into temporary tt from data.objects_altnums a join data.objects o on o.objectid = a.objectid where o.accessioned=1 and a.altnumtype <> 'Old CMS Object ID'; alter table tt drop column fingerprint;
objects_constituents:               select oc.* into temporary tt from data.objects_constituents oc where oc.objectid in ( select distinct o.objectid from data.objects o where o.accessioned=1 ); alter table tt drop column fingerprint, drop column priorownerinvnum, drop column altnameid;
objects_dimensions:                 select d.* into temporary tt from data.objects_dimensions d join data.objects o on o.objectid = d.objectid where o.accessioned=1; alter table tt drop column dimensionid;
objects_historical_data:            select h.* into temporary tt from data.objects_historical_data h join data.objects o on o.objectid = h.objectid where o.accessioned=1; alter table tt drop column fingerprint, drop column tmstable, drop column tmsrefid;
objects_terms:                      select t.* into temporary tt from data.objects_terms t join data.objects o on o.objectid = t.objectid where o.accessioned=1; alter table tt drop column fingerprint;
objects_text_entries:               select t.* into temporary tt from data.objects_text_entries t join data.objects o on o.objectid = t.objectid where o.accessioned=1 and t.textType in ('bibliography','documentary_labels_inscriptions','exhibition_history','exhibition_history_footnote','inscription_footnote','lifetime_exhibition','other_collections'); alter table tt drop column fingerprint, drop column tmstable, drop column tmsrefid;
preferred_locations:                select * into temporary tt from data.preferred_locations; alter table tt drop column mapImageURLPath;
preferred_locations_tms_locations:  select * into temporary tt from data.preferred_locations_tms_locations;
published_images:                   select uuid, cast('https://api.nga.gov/iiif/'||uuid as character varying(512)) as iiifURL, cast('https://api.nga.gov/iiif/'||uuid||'/full/!200,200/0/default.jpg' as character varying(512)) as iiifThumbURL, viewType, sequence, width, height, maxpixels, created, modified, depictstmsobjectid, assistiveText into temporary tt from data.published_images where depictstmsobjectid is not null and ri_photocredit is null and viewtype in ('primary','alternate') and coalesce(ri_isdetail,'false') = 'false';
